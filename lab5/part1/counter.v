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