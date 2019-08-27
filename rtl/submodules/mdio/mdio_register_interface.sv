

interface mdio_register_interface;


    // clocks and resets
    logic          clk;
    logic          reset;


    // device register inputs
    logic  [31:0]  transmit_data_in;


    // device register outputs
    logic  [15:0]  receive_data;
    logic          receive_valid;
    logic          transmit_ready;
    logic          busy;


    // device register control signals
    logic          transmit_we;
    logic          receive_re;


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   transmit_data_in,
        output  receive_data,
        output  receive_valid,
        output  transmit_ready,
        output  busy,
        input   transmit_we,
        input   receive_re
    );


    modport out (
        output  clk,
        output  reset,
        output  transmit_data_in,
        input   receive_data,
        input   receive_valid,
        input   transmit_ready,
        input   busy,
        output  transmit_we,
        output  receive_re
    );


endinterface

