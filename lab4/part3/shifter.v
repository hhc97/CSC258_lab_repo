module shiftbit(load_val, load_n, clk, reset_n, shift, in, out);
    input load_val, load_n, clk, reset_n, shift, in;
    output out;
    wire shift_out, load_out;

    mux2to1 shift_select(
        .x(out),
        .y(in),
        .s(shift),
        .m(shift_out)
    );

    mux2to1 load_select(
        .x(load_val),
        .y(shift_out),
        .s(load_n),
        .m(load_out)
    );

    d_flipflop store(
        .d(load_out),
        .clk(clk),
        .reset(reset_n),
        .q(out)
    );

endmodule // shiftbit


module d_flipflop(d, clk, reset, q);
    input d, clk, reset;
    output q;

    reg q;

// set q to d at positive edge of clock if reset is high, else set q to 0
    always @(posedge clk)
    begin
        if (reset == 1'b0)
            q <= 0;
        else
            q <= d;
    end

endmodule // d_flipflop


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output

    assign m = s ? y : x;

endmodule // mux2to1
