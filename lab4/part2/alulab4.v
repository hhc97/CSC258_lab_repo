module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW; // reset_n -> SW[9], ALU_function -> SW[7:5], data A -> SW[3:0]
	input [0:0] KEY; // clk -> KEY[0]
	output [7:0] LEDR; // for ALUout
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    wire [4:0] f0;
    wire [4:0] f1;
	
	reg [7:0] ALUout;

    assign HEX1 = 7'b0000001;
    assign HEX3 = 7'b0000001;


    ripple4adder r0(
        .bin({1'b0, SW[7:4], 4'b0001}),
        .led(f0)
    );

    ripple4adder r1(
        .bin({1'b0, SW[7:0]}),
        .led(f1)
    );

    always @(*)
	begin
		case(SW[7:5])
			0: ALUout = {3'b000, f0};
			1: ALUout = {3'b000, f1};
			2: ALUout = SW[7:4] + SW[3:0];
			3: ALUout = {SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0]};
			4: ALUout = {7'b0000000, SW[7] | SW[6] | SW[5] | SW[4] | SW[3] | SW[2] | SW[1] | SW[0]};
			5: ALUout = SW[7:0];
            6: ALUout = 8'b00000000;
            7: ALUout = 8'b00000000;
			default: ALUout = 8'b00000000;
		endcase
	end
	
	assign LEDR = ALUout;

    seven_seg h0(
        .bin(SW[3:0]),
        .seg(HEX0)
    );

    seven_seg h2(
        .bin(SW[7:4]),
        .seg(HEX2)
    );

    seven_seg h4(
        .bin(ALUout[3:0]),
        .seg(HEX4)
    );

    seven_seg h5(
        .bin(ALUout[7:4]),
        .seg(HEX5)
    );
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


module ripple4adder(led, bin);
    input [8:0] bin;
    output [4:0] led;
    wire a, b, c;

    fulladder a0(
        .A(bin[0]),
        .B(bin[4]),
        .cin(bin[8]),
        .cout(a),
        .S(led[0])
    );

    fulladder a1(
        .A(bin[1]),
        .B(bin[5]),
        .cin(a),
        .cout(b),
        .S(led[1])
    );

    fulladder a2(
        .A(bin[2]),
        .B(bin[6]),
        .cin(b),
        .cout(c),
        .S(led[2])
    );

    fulladder a3(
        .A(bin[3]),
        .B(bin[7]),
        .cin(c),
        .cout(led[4]),
        .S(led[3])
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
