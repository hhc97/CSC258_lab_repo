module shifter(SW, KEY, LEDR);
    input [9:0] SW; // LoadVal inputs -> SW[7:0], reset_n -> SW[9]
    input [3:0] KEY; // ASR -> KEY[3], ShiftRight -> KEY[2], Load_n -> KEY[1], clk -> KEY[0]
    output [7:0] LEDR; // output to LEDR[7:0]

    eight_bit_shifter main(
        .LoadVal(SW[7:0]),
        .Load_n(KEY[1]),
        .ShiftRight(KEY[2]),
        .ASR(KEY[3]),
        .clk(KEY[0]),
        .reset_n(SW[9]),
        .Q(LEDR[7:0])
    );

endmodule // shifter


module eight_bit_shifter(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
    input [7:0] LoadVal;
    input Load_n, ShiftRight, ASR, clk, reset_n;
    output [7:0] Q;
    wire f1;

    arithmetic_shift_copier first_bit(
        .orig(Q[7]),
        .copy(ASR),
        .out(f1)
    );

    shiftbit s7(
        .load_val(LoadVal[7]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(f1),
        .out(Q[7])
    );

    shiftbit s6(
        .load_val(LoadVal[6]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[7]),
        .out(Q[6])
    );

    shiftbit s5(
        .load_val(LoadVal[5]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[6]),
        .out(Q[5])
    );

    shiftbit s4(
        .load_val(LoadVal[4]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[5]),
        .out(Q[4])
    );

    shiftbit s3(
        .load_val(LoadVal[3]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[4]),
        .out(Q[3])
    );

    shiftbit s2(
        .load_val(LoadVal[2]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[3]),
        .out(Q[2])
    );

    shiftbit s1(
        .load_val(LoadVal[1]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[2]),
        .out(Q[1])
    );

    shiftbit s0(
        .load_val(LoadVal[0]),
        .load_n(Load_n),
        .clk(clk),
        .reset_n(reset_n),
        .shift(ShiftRight),
        .in(Q[1]),
        .out(Q[0])
    );

endmodule // eight_bit_shifter


module arithmetic_shift_copier(orig, copy, out);
    input orig, copy;
    output out;

    reg out;

    always @(*)
    begin
        if (copy == 1'b1)
            out <= orig;
        else
            out <= 0;
    end

endmodule // arithmetic_shift_copier


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
        .reset_n(reset_n),
        .q(out)
    );

endmodule // shiftbit


module d_flipflop(d, clk, reset_n, q);
    input d, clk, reset_n;
    output q;

    reg q;

// set q to d at positive edge of clock if reset_n is high, else set q to 0
    always @(posedge clk)
    begin
        if (reset_n == 1'b0)
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
