module lut(key, out);
    input [2:0] key;
    output [0:13] out;

    reg [0:13] out;

    always @(*)
    begin
        case (key)
            0 : out = 14'b10101000000000; // S
            1 : out = 14'b11100000000000; // T
            2 : out = 14'b10101110000000; // U
            3 : out = 14'b10101011100000; // V
            4 : out = 14'b10111011100000; // W
            5 : out = 14'b11101010111000; // X
            6 : out = 14'b11101011101110; // Y
            7 : out = 14'b11101110101000; // Z
            default: out = 14'b00000000000000;
        endcase
    end
endmodule // lut
