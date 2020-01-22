module hex(SW, HEX0);
    input [9:0] SW;
    output [6:0] HEX0;
    assign SW[0] = HEX0[0];

endmodule