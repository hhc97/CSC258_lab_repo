module ripple4adder(LEDR, SW);
    input [8:0] SW;
    output [4:0] LEDR;
    wire a, b, c;

    fulladder a0(
        .A(SW[0]),
        .B(SW[4]),
        .cin(SW[8]),
        .cout(a),
        .S(LEDR[0])
    );

    fulladder a1(
        .A(SW[1]),
        .B(SW[5]),
        .cin(a),
        .cout(b),
        .S(LEDR[1])
    );

    fulladder a2(
        .A(SW[2]),
        .B(SW[6]),
        .cin(b),
        .cout(c),
        .S(LEDR[2])
    );

    fulladder a3(
        .A(SW[3]),
        .B(SW[7]),
        .cin(c),
        .cout(LEDR[4]),
        .S(LEDR[3])
    );
endmodule


module fulladder(A, B, cin, cout, S);
    input A;
    input B;
    input cin;
    output cout;
    output S;
    
    assign S = cin ^ (A ^ B);
    assign cout = A & B | A & cin | B & cin;
endmodule
