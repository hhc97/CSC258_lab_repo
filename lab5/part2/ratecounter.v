module counter(reset_n, frequency, clk, out);
    input reset_n, clk;
    input [1:0] frequency;
    output [3:0] out;

    wire [27:0] one, half, quarter;

    reg count_up;

    // ratedivider rate_one(1'b1, 28'd49999999, clk, reset_n, one);
    // ratedivider rate_half(1'b1, 28'd99999999, clk, reset_n, half);
    // ratedivider rate_quarter(1'b1, 28'd199999999, clk, reset_n, quarter);
    
    ratedivider rate_one(1'b1, 28'd49, clk, reset_n, one);
    ratedivider rate_half(1'b1, 28'd99, clk, reset_n, half);
    ratedivider rate_quarter(1'b1, 28'd199, clk, reset_n, quarter);

    always @(*)
        begin
            case (frequency)
                0 : count_up = 1'b1;
                1 : count_up = (one == 0) ? 1 : 0;
                2 : count_up = (half == 0) ? 1 : 0;
                3 : count_up = (quarter == 0) ? 1 : 0;
                default : count_up = 1'b1;
            endcase
        end
    
    displaycounter disp(count_up, clk, reset_n, out);
endmodule // counter


module displaycounter(enable, clk, reset_n, out);
    input enable, clk, reset_n;
    output [3:0] out;

    reg [3:0] out;

    always @(posedge clk, negedge reset_n)
    begin
        if (reset_n == 1'b0)
            out <= 0;
        else if (enable == 1'b1)
            begin
                if (out == 4'b1111)
                    out <= 0;
                else
                    out <= out + 1'b1;
            end
    end
endmodule // displaycounter


module ratedivider(enable, load, clk, reset_n, out);
    input enable, clk, reset_n;
    input [27:0] load; // to store numbers up to 200M for 0.25Hz

    output reg [27:0] out;

    always @(posedge clk)
    begin
        if (reset_n == 1'b0)
            out <= 0;
        else if (enable == 1'b1)
            begin
                if (out == 0)
                    out <= load;
                else
                    out <= out - 1'b1; 
            end
    end
endmodule // ratedivider



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
endmodule // seven_seg
