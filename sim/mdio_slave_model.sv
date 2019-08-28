

module mdio_slave_model(
    input   logic         reset,
    input   logic  [4:0]  phy_address,
    input   logic         mdc,
    inout   wire          mdio
    );


    typedef  enum  logic  [2:0]
    {
        WAIT0 = 3'd0,
        WAIT1 = 3'd1,
        GETOP = 3'd2,
        TA0   = 3'd3,
        TA1   = 3'd4,
        DATA  = 3'd5,
        IDLE0 = 3'd6,
        IDLE1 = 3'd7
    }   states;


    // registers
    states                state;
    logic   [5:0]         bit_count;
    logic   [1:0]         op;
    logic   [4:0]         ra;
    logic   [4:0]         pa;
    logic   [15:0]        data;
    logic   [31:0][15:0]  data_reg;


    // internal wires
    states                state_next;
    logic   [5:0]         bit_count_next;
    logic   [1:0]         op_next;
    logic   [4:0]         ra_next;
    logic   [4:0]         pa_next;
    logic   [15:0]        data_next;
    logic   [31:0][15:0]  data_reg_next;
    logic                 mdio_out_en;
    logic                 mdio_out;
    logic                 mdio_in;


    always @(posedge mdc or posedge reset) begin
        if(reset) begin
            state     = WAIT0;
            bit_count = 6'd1;
            op        = 2'd0;
            ra        = 5'd0;
            pa        = 5'd0;
            data      = 16'd0;
            data_reg  = {32{16'd0}};
        end else begin
            state     = state_next;
            bit_count = bit_count_next;
            op        = op_next;
            ra        = ra_next;
            pa        = pa_next;
            data      = data_next;
            data_reg  = data_reg_next;
        end
    end


    always_comb begin
        // defaults
        state_next     = state;     // retain old value
        bit_count_next = bit_count; // retain old value
        op_next        = op;        // retain old value
        ra_next        = ra;        // retain old value
        pa_next        = pa;        // retain old value
        data_next      = data;      // retain old value
        data_reg_next  = data_reg;  // retain old value
        mdio_out_en    = 1'b0;      // not enabled
        mdio_out       = 1'b1;      // output 1


        case(state)
            WAIT0:  if(mdio_in == 1'b0) state_next = WAIT1; // check for first start bit
            WAIT1:  begin
                        bit_count_next = 6'd1;  // reset bit count
                        state_next     = GETOP; // check for second start bit
                                                // (can be 0 or 1 according to different charts so no check is done here)
                    end
            GETOP:  begin
                        bit_count_next = bit_count + 6'd1; // increment bit count

                        // shift in op, ra, and pa from the mdio pin
                        {op_next, ra_next, pa_next} = {op[0], ra, pa, mdio_in};
                        if(bit_count == 6'd12) state_next = TA0;
                    end
            TA0:    begin
                        if(op == 2'b01) begin
                            if(mdio_in == 1'b0)
                                state_next = WAIT0;    // if a zero is written reset the state machine
                            else
                                state_next = TA1;      // on a write the master must drive a 1 here
                        end
                        state_next = TA1;
                    end
            TA1:    begin
                        if(op == 2'b01) begin
                            if(mdio_in == 1'b1)
                                state_next = WAIT0;    // if a one is written reset the state machine
                            else
                                state_next = DATA;     // on a write the master must drive a 0 here
                        end else begin
                            data_next  = data_reg[ra]; // preload the data to be read into the data register
                            state_next = DATA;
                        end
                    end
            DATA:   begin
                        bit_count_next = bit_count + 6'd1; // increment bit count

                        // only do a read/write if the physical address matches
                        if(pa == phy_address) begin
                            case(op)
                                2'b00: ; // do nothing???
                                2'b01: data_next = {data[14:0], mdio_in}; // do a write
                                2'b10,
                                2'b11: begin
                                           mdio_out_en = 1'b1;                   // enable output on mdio pin
                                           mdio_out    = data[15];               // drive current data bit to mdio pin
                                           data_next   = {data[14:0], data[15]}; // rotate register contents
                                       end
                            endcase
                        end
                        if(bit_count == 6'd28) state_next = IDLE0;
                    end
            IDLE0:  begin
                        if((pa == phy_address) && (op == 2'b01))
                            data_reg_next[ra] = data; // write the shifted in value to the correct register

                        state_next = IDLE1;
                    end
            IDLE1:  state_next = WAIT0;
        endcase
    end


    assign mdio    = (mdio_out_en) ? mdio_out : 1'bz;
    assign mdio_in = mdio;


endmodule

