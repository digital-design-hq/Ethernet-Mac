

module mdio_core(
    mdio_register_interface.in  reg_io,

    output  logic               mdc,
    inout   wire                mdio
    );


    // wires
    logic          clk_en;
    logic          transmit_ready;
    logic          receive_valid;
    logic  [15:0]  receive_data;
    logic  [31:0]  transmit_data;


    // transmit data register
    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin
        if(reg_io.reset)
            transmit_data <= 32'd0;
        else if(reg_io.transmit_we)
            transmit_data <= reg_io.transmit_data_in;
        else
            transmit_data <= transmit_data;
    end


    // receive data register
    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin
        if(reg_io.reset)
            reg_io.receive_data <= 16'd0;
        else if(receive_valid)
            reg_io.receive_data <= receive_data;
        else
            reg_io.receive_data <= reg_io.receive_data;
    end


    // receive valid register
    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin
        if(reg_io.reset)
            reg_io.receive_valid <= 1'b0;   // reset valid
        else if(receive_valid)
            reg_io.receive_valid <= 1'b1;   // set valid (this gets priority if the condition below is active at the same time)
        else if(reg_io.receive_re)
            reg_io.receive_valid <= 1'b0;   // reset valid
        else
            reg_io.receive_valid <= reg_io.receive_valid;
    end


    // transmit ready register
    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin
        if(reg_io.reset)
            reg_io.transmit_ready <= 1'b1;  // set ready
        else if(reg_io.transmit_we)
            reg_io.transmit_ready <= 1'b0;  // reset ready when writting transmit_data byte (this gets priority if the condition below is active at the same time)
        else if(transmit_ready)
            reg_io.transmit_ready <= 1'b1;  // set ready if data is already valid and transmitter reads the stored byte
        else
            reg_io.transmit_ready <= reg_io.transmit_ready;
    end


    mdio_controller
    mdio_controller(
        .clk              (reg_io.clk),
        .reset            (reg_io.reset),
        .transmit_data,
        .receive_data,
        .clk_en,
        .transmit_valid   (~reg_io.transmit_ready),
        .transmit_ready,
        .receive_valid,
        .busy             (reg_io.busy),
        .mdc,
        .mdio
    );


    mdio_clock_en
    mdio_clock_en(
        .clk              (reg_io.clk),
        .reset            (reg_io.reset),
        .clk_en
    );


endmodule

