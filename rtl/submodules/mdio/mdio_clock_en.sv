

// this assumes a 100 MHz clock, which makes for a 1 MHz ethernet smi clock
module mdio_clock_en(
    input   logic          clk,
    input   logic          reset,

    output  logic          clk_en
    );


    logic  [5:0]  cycle_counter;
    logic  [5:0]  cycle_counter_next;


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycle_counter <= 6'd1;
        else
            cycle_counter <= cycle_counter_next;
    end


    // combinationial logic
    assign clk_en             = (cycle_counter >= 6'd50);
    assign cycle_counter_next = (clk_en) ? 6'd1 : cycle_counter + 6'd1;


endmodule

