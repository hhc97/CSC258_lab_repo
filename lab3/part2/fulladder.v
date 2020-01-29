module full(LEDR, SW);
    input [9:7] SW;
    output [1:0] LEDR;

    fulladder a0(
        .A(SW[9]),
        .B(SW[8]),
        .cin(SW[7]),
        .cout(LEDR[1]),
        .S(LEDR[0])
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