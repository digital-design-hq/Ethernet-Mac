

// register map
// address //   bits    //  registers          // type   //  access type  // value meaning
//       0      [31:16]     opcode/upper data     data       write
//       0      [15:0]      lower data            data       read/write
//       1      0           transmit ready        status     read            {1 for ready, 0 for not ready}
//       1      1           receive valid         status     read            {1 for valid, 0 for not valid}
//       1      2           busy                  status     read            {1 for busy,  0 for not busy}


module register_map(
    register_interface.in        reg_adapter_io,
    mdio_register_interface.out  reg_io
    );


    // this is a known value so we preset it correctly.
    parameter REGS         = 2;
    parameter POWEROF2REGS = (1 << $clog2(REGS));


    // assign resets and clocks
    assign reg_io.clk   = reg_adapter_io.clk;
    assign reg_io.reset = reg_adapter_io.reset;


    // map native registers to generic register array of bus adapter
    always_comb begin
        // defaults
        reg_adapter_io.data_out          = '{POWEROF2REGS{32'b0}};        // set all output lines to zero


        // data register mapping
        reg_io.transmit_we               = reg_adapter_io.write_en[0];    // write enable map
        reg_io.receive_re                = reg_adapter_io.read_en [0];    // read enable map
        reg_io.transmit_data_in          = reg_adapter_io.data_in [31:0]; // input map
        reg_adapter_io.data_out[0][15:0] = reg_io.receive_data;           // output map


        // status register mapping
        reg_adapter_io.data_out[1][0]    = reg_io.transmit_ready;         // output map
        reg_adapter_io.data_out[1][1]    = reg_io.receive_valid;          // output map
        reg_adapter_io.data_out[1][2]    = reg_io.busy;                   // output map
    end


endmodule

