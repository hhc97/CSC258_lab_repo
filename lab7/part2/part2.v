// Part 2 skeleton
module part2
    (
        CLOCK_50,                          //    On Board 50 MHz
        // Your inputs and outputs here
        KEY,
        SW,
        // The ports below are for the VGA output.  Do not change.
        VGA_CLK,                           //    VGA Clock
        VGA_HS,                            //    VGA H_SYNC
        VGA_VS,                            //    VGA V_SYNC
        VGA_BLANK_N,                       //    VGA BLANK
        VGA_SYNC_N,                        //    VGA SYNC
        VGA_R,                             //    VGA Red[9:0]
        VGA_G,                             //    VGA Green[9:0]
        VGA_B                              //    VGA Blue[9:0]
    );

    input           CLOCK_50;              //    50 MHz
    input   [9:0]   SW;
    input   [3:0]   KEY;

    // Declare your inputs and outputs here
    // Do not change the following outputs
    output             VGA_CLK;                  //    VGA Clock
    output             VGA_HS;                   //    VGA H_SYNC
    output             VGA_VS;                   //    VGA V_SYNC
    output             VGA_BLANK_N;              //    VGA BLANK
    output             VGA_SYNC_N;               //    VGA SYNC
    output    [9:0]    VGA_R;                    //    VGA Red[9:0]
    output    [9:0]    VGA_G;                    //    VGA Green[9:0]
    output    [9:0]    VGA_B;                    //    VGA Blue[9:0]
    
    wire resetn;
    assign resetn = KEY[0];
    
    // Create the colour, x, y and writeEn wires that are inputs to the controller.
    wire [2:0] colour;
    wire [7:0] x;
    wire [6:0] y;
    wire writeEn;

    // Create an Instance of a VGA controller - there can be only one!
    // Define the number of colours as well as the initial background
    // image file (.MIF) for the controller.
    vga_adapter VGA(
            .resetn(resetn),
            .clock(CLOCK_50),
            .colour(colour),
            .x(x),
            .y(y),
            .plot(writeEn),
            /* Signals for the DAC to drive the monitor. */
            .VGA_R(VGA_R),
            .VGA_G(VGA_G),
            .VGA_B(VGA_B),
            .VGA_HS(VGA_HS),
            .VGA_VS(VGA_VS),
            .VGA_BLANK(VGA_BLANK_N),
            .VGA_SYNC(VGA_SYNC_N),
            .VGA_CLK(VGA_CLK));
        defparam VGA.RESOLUTION = "160x120";
        defparam VGA.MONOCHROME = "FALSE";
        defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
        defparam VGA.BACKGROUND_IMAGE = "black.mif";
            
    // Put your code here. Your code should produce signals x,y,colour and writeEn/plot
    // for the VGA controller, in addition to any other functionality your design may require.
    
    // Instansiate datapath
    // datapath d0(...);
    datapath d0(SW[6:0], SW[9:7], CLOCK_50, KEY[0], enable, ld_x, ld_y, ld_c, x, y, colour);

    // Instansiate FSM control
    // control c0(...);
    control c0(~KEY[3], KEY[0], ~KEY[1], CLOCK_50, enable, ld_x, ld_y, ld_c, writeEn);

endmodule


module datapath(data_in, colour, clock, reset_n, enable, ld_x, ld_y, ld_c, X, Y, Colour);
    input reset_n, enable, clock, ld_x, ld_y, ld_c;
    input [6:0] data_in;
    input [2:0] colour;
    output [7:0] X;
    output [6:0] Y;
    output [2:0] Colour;
    reg [7:0] x1;
    reg [6:0] y1;
    reg [2:0] co1;
    
    wire [1:0] c1, c2, c3;
    
    always @(posedge clock)
    begin
        if (!reset_n) begin
            x1 <= 8'b0; 
            y1 <= 7'b0;
            co1 <= 3'b0;
        end
        else begin
        if (ld_x)
            x1 <= {1'b0, data_in};
        if (ld_y)
            y1 <= data_in;
        if (ld_c)
            co1 <= colour;
        end
    end

    count_up4 m1(clock, reset_n, enable, c1);
    count_up4 m2(clock, reset_n, enable, c2);
    assign enable_1 = (c2 == 2'b11) ? 1 : 0;
    count_up4 m3(clock, reset_n, enable_1, c3);
    assign X = x1 + c1;
    assign Y = y1 + c3;
    assign Colour = co1;
endmodule

// counter from 00 to 11 on posedge clock
module count_up4(clock, reset_n, enable, q);
    input clock, reset_n, enable;
    output reg [1:0] q;
    
    always @(posedge clock)
    begin
        if(reset_n == 1'b0)
            q <= 2'b00;
        else if (enable == 1'b1)
        begin
            if (q == 2'b11)
                q <= 2'b00;
            else
                q <= q + 1'b1;
        end
    end
endmodule


module rate_counter16(clock, reset_n, enable, q);
    input clock, reset_n, enable;
    output reg [4:0] q;
    
    always @(posedge clock)
    begin
        if(reset_n == 1'b0)
            q <= 5'b10000;
        else if(enable == 1'b1)
        begin
            if (q == 5'b00000)
                q <= 5'b10000;
            else
                q <= q - 1'b1;
        end
    end
endmodule


module control(go, reset_n, KEY, clock, enable, ld_x, ld_y, ld_c, plot);
    input go, reset_n, clock, KEY;
    output reg enable, ld_x, ld_y, ld_c, plot;

    reg [3:0] current_state, next_state;

    wire [4:0] q;
    wire clock_1;

    localparam
    S_LOAD_X = 4'd0,
    S_LOAD_X_WAIT = 4'd1,
    S_LOAD_Y = 4'd2,
    S_LOAD_Y_WAIT = 4'd3,
    S_CYCLE_0 = 4'd4;

    rate_counter16 m1(clock, reset_n, 1'b1, q);
    assign clock_1 = (q == 5'b00000) ? 1 : 0;
    
    always @(*)
    begin: state_table
        case (current_state)
            S_LOAD_X: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X;
            S_LOAD_X_WAIT: next_state = go ? S_LOAD_X_WAIT : S_LOAD_Y;
            S_LOAD_Y: next_state = KEY ? S_LOAD_Y_WAIT : S_LOAD_Y;
            S_LOAD_Y_WAIT: next_state = KEY ? S_LOAD_Y_WAIT : S_CYCLE_0;
            S_CYCLE_0: next_state = S_LOAD_X;
            default: next_state = S_LOAD_X;
        endcase
    end
	
    always @(*)
    begin: enable_signals
        // default signals are 0
        ld_x = 1'b0;
        ld_y = 1'b0;
        ld_c = 1'b0;
        enable = 1'b0;
        plot = 1'b0;

        case (current_state)
            S_LOAD_X:begin
                ld_x = 1'b1;
                end
            S_LOAD_Y:begin
                ld_y = 1'b1;
                end
            S_CYCLE_0:begin
                ld_c = 1'b1;
                enable = 1'b1;
                plot = 1'b1;
                end
        endcase
    end

    always @(posedge clock_1)
    begin: state_FFs
        if (!reset_n)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end
endmodule


module combination(data_in, colour, reset_n, clock, go, KEY, X, Y, Colour);
    input [6:0] data_in;
    input [2:0] colour;
    input reset_n, clock, go, KEY;
    output [7:0] X;
    output [6:0] Y;
    output [2:0] Colour;
    
    wire enable, ld_x, ld_y, ld_c, plot;
    
    control m1(go, reset_n, KEY, clock, enable, ld_x, ld_y, ld_c, plot);
    datapath m2(data_in, colour, clock, reset_n, enable, ld_x, ld_y, ld_c, X, Y, Colour);
endmodule
