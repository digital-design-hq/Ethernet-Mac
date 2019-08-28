

module mdio_controller(
    input   logic          clk,
    input   logic          reset,

    input   logic  [31:0]  transmit_data,   // the data we want to write to the slave
    output  logic  [15:0]  receive_data,    // the data that was read from the slave

    input   logic          clk_en,

    input   logic          transmit_valid,  // this line tells this core when a command is ready to be processed
    output  logic          transmit_ready,  // this signals when the write data has been used
    output  logic          receive_valid,   // this signals that the data on the read data lines is valid
    output  logic          busy,            // this signals if the core is busy or not

    output  logic          mdc,
    inout   wire           mdio
    );


    typedef  enum  logic  [1:0]
    {
        IDLE   = 2'd0,
        CYCLE1 = 2'd1,
        CYCLE2 = 2'd2,
        FINISH = 2'd3
    }   states;


    // registers
    states          state;                   // state register
    logic   [5:0]   bit_count;               // bit counter register
    logic   [2:0]   idle_count;              // idle counter register
    logic   [15:0]  upper_data_reg;          // upper data register
    logic   [15:0]  lower_data_reg;          // lower data register
    logic   [1:0]   opcode_reg;              // opcode register
    logic           transmit_ready_reg;      // transmit ready register
    logic           receive_valid_reg;       // receive valid register
    logic           mdio_out_reg;            // data output register
    logic           mdio_out_en_reg;         // data output enable register


    // other internal logic signals
    states          state_next;
    logic   [5:0]   bit_count_next;
    logic   [2:0]   idle_count_next;
    logic   [15:0]  upper_data_reg_next;
    logic   [15:0]  lower_data_reg_next;
    logic   [1:0]   opcode_reg_next;
    logic           transmit_ready_reg_next;
    logic           receive_valid_reg_next;
    logic           mdc_next;
    logic           mdio_in;
    logic           mdio_out_reg_next;
    logic           mdio_out_en_reg_next;


    // register logic
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            state              <= IDLE;
            bit_count          <= 6'd1;
            idle_count         <= 3'd1;
            upper_data_reg     <= 16'd0;
            lower_data_reg     <= 16'd0;
            opcode_reg         <= 2'd0;
            transmit_ready_reg <= 1'd0;
            receive_valid_reg  <= 1'd0;
            mdc                <= 1'b0;
            mdio_out_reg       <= 1'b0;
            mdio_out_en_reg    <= 1'b0;
        end else begin
            state              <= state_next;
            bit_count          <= bit_count_next;
            idle_count         <= idle_count_next;
            upper_data_reg     <= upper_data_reg_next;
            lower_data_reg     <= lower_data_reg_next;
            opcode_reg         <= opcode_reg_next;
            transmit_ready_reg <= transmit_ready_reg_next;
            receive_valid_reg  <= receive_valid_reg_next;
            mdc                <= mdc_next;
            mdio_out_reg       <= mdio_out_reg_next;
            mdio_out_en_reg    <= mdio_out_en_reg_next;
        end
    end


    // combinationial logic
    always_comb begin
        // defaults
        state_next              = IDLE;            // go to idle
        bit_count_next          = bit_count;       // keep old value
        idle_count_next         = idle_count;      // keep old value
        upper_data_reg_next     = upper_data_reg;  // keep old value
        lower_data_reg_next     = lower_data_reg;  // keep old value
        opcode_reg_next         = opcode_reg;      // keep old value
        mdc_next                = mdc;             // keep old value
        mdio_out_reg_next       = mdio_out_reg;    // keep old value
        mdio_out_en_reg_next    = mdio_out_en_reg; // keep old value
        busy                    = 1'b1;            // signal busy
        transmit_ready_reg_next = 1'b0;            // signal not ready
        receive_valid_reg_next  = 1'b0;            // read not valid


        case(state)
            IDLE: begin
                bit_count_next  = 6'd1;
                idle_count_next = 3'd1;
                busy            = 1'b0;

                if(!reset && transmit_valid && clk_en) begin
                    transmit_ready_reg_next = 1'b1;                 // signal ready
                    opcode_reg_next         = transmit_data[29:28]; // set opcode reg to input opcode
                    upper_data_reg_next     = transmit_data[31:16]; // set upper data reg to input data
                    lower_data_reg_next     = transmit_data[15:0];  // set upper data reg to input data

                    // next state logic
                    state_next = CYCLE1;
                end else begin
                    // next state logic
                    state_next = IDLE;
                end
            end


            // lower clock and set/capture data
            CYCLE1: begin
                if(clk_en) begin
                    mdc_next = 1'b0; // lower clock
                    if(opcode_reg == 2'b10) begin
                        if(bit_count >= 6'd15) begin
                            mdio_out_en_reg_next = 1'b0;                                       // disable output
                        end else begin
                            mdio_out_en_reg_next = 1'b1;                                       // enable output
                            mdio_out_reg_next    = upper_data_reg[15];                         // output a new bit
                        end
                        if(bit_count < 6'd17)
                            upper_data_reg_next  = {upper_data_reg[14:0], upper_data_reg[15]}; // rotate output data
                        else
                            lower_data_reg_next  = {lower_data_reg[14:0], mdio_in};            // capture input data
                    end else begin // if opcode is not 10 then we are doing a write so set new data to the line here
                        mdio_out_reg_next        = upper_data_reg[15];                         // output a new bit
                        mdio_out_en_reg_next     = 1'b1;                                       // enable output
                        {upper_data_reg_next, lower_data_reg_next} = {upper_data_reg[14:0], lower_data_reg, upper_data_reg[15]}; // rotate data
                    end
                end

                // next state logic
                state_next = (clk_en) ? CYCLE2 : CYCLE1;
            end


            // raise clock and capture data
            CYCLE2: begin
                if(clk_en) begin
                    mdc_next = 1'b1; // raise clock

                    if(bit_count == 6'd32) begin
                        if(opcode_reg == 2'b10)
                            receive_valid_reg_next = 1'b1; // send read valid signal

                        state_next = FINISH;
                    end else begin
                        bit_count_next = bit_count + 6'd1; // increment bit counter

                        state_next = CYCLE1;
                    end
                end else begin
                    state_next = CYCLE2;
                end
            end


            // toggle clock a few times to give the bus some idle cycles
            FINISH: begin
                if(clk_en) begin
                    mdc_next             = ~mdc;           // toggle clock
                    mdio_out_en_reg_next = 1'b0;           // disable output
                    idle_count_next      = idle_count + 3'd1;
                end

                // next state logic
                state_next = (clk_en && (idle_count == 6'd5)) ? IDLE : FINISH;
            end


        endcase


    end


    assign mdio           = (mdio_out_en_reg) ? mdio_out_reg : 1'bz;
    assign mdio_in        = mdio;
    assign receive_data   = lower_data_reg;
    assign transmit_ready = transmit_ready_reg;
    assign receive_valid  = receive_valid_reg;


endmodule

