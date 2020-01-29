module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [7:0] SW; // A -> SW[7:4], B -> SW[3:0]
	input [2:0] KEY; // function inputs
	output [7:0] LEDR; // for ALUout
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	reg [7:0] ALUout;

    assign HEX1 = 7'b0000001;
    assign HEX3 = 7'b0000001;

    always @(*)
	begin
		case(KEY[2:0])
			0: ALUout = ;
			1: ALUout = ;
			2: ALUout = ;
			3: ALUout = ;
			4: ALUout = ;
			5: ALUout = ;
			default: ALUout = 8'b00000000;
		endcase
	end
	
	assign LEDR = ALUout;







endmodule


module seven_seg(seg, bin);
    input [3:0] bin;
    output [0:6] seg;
    reg [0:6] seg;

    always @(bin)
    begin
        case (bin)
            0 : seg = 7'b0000001;
            1 : seg = 7'b1001111;
            2 : seg = 7'b0010010;
            3 : seg = 7'b0000110;
            4 : seg = 7'b1001100;
            5 : seg = 7'b0100100;
            6 : seg = 7'b0100000;
            7 : seg = 7'b0001111;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0000100;
            10 : seg = 7'b0001000;
            11 : seg = 7'b1100000;
            12 : seg = 7'b0110001;
            13 : seg = 7'b1000010;
            14 : seg = 7'b0110000;
            15 : seg = 7'b0111000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule


module ripple4adder(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
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
