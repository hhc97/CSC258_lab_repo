//SW[4:0] data inputs
//SW[9] (s0) and SW[8] (s1) select signal

//LEDR[0] output display

module mux4(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
    wire up, down;

    mux2to1 u0(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[9]),
        .m(up)
        );

    mux2to1 u1(
        .x(SW[2]),
        .y(SW[3]),
        .s(SW[9]),
        .m(down)
        );

    mux2to1 u2(
        .x(up),
        .y(down),
        .s(SW[8]),
        .m(LEDR[0])
        );

endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule
