module counter_eight_bit(enable, clk, clear_b, out);
    input enable, clk, clear_b;
    output [7:0] out;

    wire bit1, bit2, bit3, bit4, bit5, bit6, bit7;
    
    assign bit1 = enable & out[0];
    assign bit2 = bit1 & out[1];
    assign bit3 = bit2 & out[2];
    assign bit4 = bit3 & out[3];
    assign bit5 = bit4 & out[4];
    assign bit6 = bit5 & out[5];
    assign bit7 = bit6 & out[6];

    tflipflop t0(enable, clk, clear_b, out[0]);
    tflipflop t1(bit1, clk, clear_b, out[1]);
    tflipflop t2(bit2, clk, clear_b, out[2]);
    tflipflop t3(bit3, clk, clear_b, out[3]);
    tflipflop t4(bit4, clk, clear_b, out[4]);
    tflipflop t5(bit5, clk, clear_b, out[5]);
    tflipflop t6(bit6, clk, clear_b, out[6]);
    tflipflop t7(bit7, clk, clear_b, out[7]);

endmodule // counter_eight_bit


module tflipflop(enable, clk, clear_b, out);
    input clk, clear_b, enable;
    output out;

    reg out;

    always @(posedge clk, negedge clear_b)
    begin
        if (clear_b == 1'b0)
            out <= 0;
        else if (enable == 1'b1)
            out <= ~out;
    end

endmodule // tflipflop
