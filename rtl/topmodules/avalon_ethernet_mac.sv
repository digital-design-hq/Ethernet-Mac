

module avalon_ethernet_mac(
    input   logic          clk,
    input   logic          reset,

    input   logic          reg_read,
    input   logic          reg_write,
    input   logic          reg_address,
    input   logic  [31:0]  reg_data_in,
    output  logic          reg_read_valid,
    output  logic  [31:0]  reg_data_out,

    output  logic          irq,

    output  logic          mdc,
    inout   wire           mdio
    );


    // Interface parameters can only be set when an interface is
    // instantiated inside a module like below, they can't be set when
    // using them as a port on a module. As a result I didn't end
    // up making the avalon bus an interface because it's parameters
    // couldn't be set inside the peripheral only outside of it.
    // If anybody is aware of a way to do this feel free to change
    // the bus to an interface.
    register_interface       #(.REGS(2))  reg_adapter_io();
    mdio_register_interface               reg_io();


    // instantiate the register adapter
    avalon_register_adapter  #(.REGS(2), .LATENCY(1))
    avalon_register_adapter(
        .clk,
        .reset,
        .read        (reg_read),
        .write       (reg_write),
        .address     (reg_address),
        .data_in     (reg_data_in),
        .read_valid  (reg_read_valid),
        .data_out    (reg_data_out),
        .reg_io      (reg_adapter_io)
    );


    // instantiate the register map
    register_map
    register_map(
        .reg_adapter_io,
        .reg_io
    );


    mdio_core
    mdio_core(
        .reg_io,
        .mdc,
        .mdio
    );


endmodule

