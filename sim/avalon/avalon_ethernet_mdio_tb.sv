`timescale 1ns / 100ps


// this is just a simple testbench so you can visually inspect the waveforms of the peripheral, to run it fire up modelsim, click file,
// click change directory and set the directory to the folder of this testbench file, then type "do run.do" without the quotes in the
// transcript window and hit enter.


module avalon_ethernet_mdio_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          reg_read;
    logic          reg_write;

    // output wires
    logic          reg_read_valid;
    logic  [31:0]  reg_data_out;
    logic          irq;
    logic          mdc;

    // inout wires
    wire           mdio;

    // extra wires needed for testing
    logic  [31:0]  data_in;
    logic  [31:0]  data_out;
    logic  [31:0]  address;
    logic          read;
    logic          write;
    logic          read_valid;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    avalon_ethernet_mac
    dut(
        .clk,
        .reset,
        .reg_read,
        .reg_write,
        .reg_address     (address[2]),
        .reg_data_in     (data_in),
        .reg_read_valid,
        .reg_data_out,
        .irq,
        .mdc,
        .mdio
    );


    mdio_slave_model
    mdio_slave_model(
        .reset,
        .phy_address     (5'd7), // set physical address to 7 for testing
        .mdc,
        .mdio
    );


    // extra logic needed to do the testing
    always_comb begin : test_logic
        // default
        reg_read  = 1'b0;
        reg_write = 1'b0;


        // read/write signal generation
        if(address >= 0 && address <= 7) begin
            if(read)  reg_read  = 1'b1;
            if(write) reg_write = 1'b1;
        end


        // assign data_out
        case(reg_read_valid)
            1'b0: data_out = reg_data_out;
            1'b1: data_out = reg_data_out;
        endcase


        // set read_valid
        read_valid = reg_read_valid;
    end


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/
    
    integer                seed   = 943247;
    integer                errors = 0;
    integer                i;
    logic    [1:0]         op;
    logic    [4:0]         ra;
    logic    [4:0]         pa;
    logic    [15:0]        data;
    logic    [31:0][15:0]  test_data;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        read           = 1'b0;
        write          = 1'b0;
        address        = 32'b0;
        data_in        = 32'd0;
    end


    // create clock sources
    always begin
        #5
        clk = 1'b0;
        #5
        clk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        // set the random seed
        $urandom(seed);

        // reset the system
        hardware_reset();

        // set field constants
        pa = 5'd7;  // set phy address 7

        // randomize data to be written
        for(i = 0; i < 32; i++)
            test_data[i] = $urandom;

        // set opcode to write
        op   = 2'b01; 

        // write all test data to mdio core
        for(i = 0; i < 32; i++) begin
            ra  = i;
            tx({2'b01, op, ra, pa, 2'b10, test_data[i]});
        end

        // set opcode to read
        op   = 2'b10; 

        // read back all test data from mdio core and check it matches
        for(i = 0; i < 32; i++) begin
            ra  = i;
            tx({2'b01, op, ra, pa, 2'b00, 16'd0});
            rx();

            if(data_out != test_data[i]) begin
               $warning("Result Miss Match\n got:      %d\n expected: %d",
                   data_out, test_data[i]
               );
               errors++;
            end
        end

        $display("Total Errors: %d", errors);

        $stop;
     end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardware_reset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0;
    endtask


    task write_data(input logic [31:0] _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; data_in = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 32'd0;    data_in = 32'd0;
        end
    endtask


    task read_data(input logic [31:0] _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 32'd0;
            wait(read_valid);
        end
    endtask


    task tx(input logic [31:0] _data);
        begin
            do begin
                read_data(32'd4);           // check transmitReady flag
            end while(data_out[0] == 1'b0); // wait for it to be ready
            write_data(32'd0, _data);       // write the data
        end
    endtask


    task rx();
        begin
            do begin
                read_data(32'd4);           // check receiveValid flag
            end while(data_out[1] == 1'b0); // wait for it to be valid
            read_data(32'd0);               // read the data
        end
    endtask


endmodule

