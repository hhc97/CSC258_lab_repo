module ram_top(SW, KEY, HEX0, HEX2, HEX4, HEX5);
    input [9:0] SW;
    input [0:0] KEY;
    output [0:6] HEX0, HEX2, HEX4, HEX5;

    wire [3:0] d_out;

    ram32x4 ram(SW[8:4], KEY[0], SW[3:0], SW[9], d_out);

    seven_seg h0(HEX0, d_out);
    seven_seg h2(HEX2, SW[3:0]);
    seven_seg h4(HEX4, SW[7:4]);
    seven_seg h5(HEX5, {3'b000, SW[8]});

endmodule // ram_top


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


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module ram32x4 (
    address,
    clock,
    data,
    wren,
    q);

    input    [4:0]  address;
    input      clock;
    input    [3:0]  data;
    input      wren;
    output    [3:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
    tri1      clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

    wire [3:0] sub_wire0;
    wire [3:0] q = sub_wire0[3:0];

    altsyncram    altsyncram_component (
                .address_a (address),
                .clock0 (clock),
                .data_a (data),
                .wren_a (wren),
                .q_a (sub_wire0),
                .aclr0 (1'b0),
                .aclr1 (1'b0),
                .address_b (1'b1),
                .addressstall_a (1'b0),
                .addressstall_b (1'b0),
                .byteena_a (1'b1),
                .byteena_b (1'b1),
                .clock1 (1'b1),
                .clocken0 (1'b1),
                .clocken1 (1'b1),
                .clocken2 (1'b1),
                .clocken3 (1'b1),
                .data_b (1'b1),
                .eccstatus (),
                .q_b (),
                .rden_a (1'b1),
                .rden_b (1'b1),
                .wren_b (1'b0));
    defparam
        altsyncram_component.clock_enable_input_a = "BYPASS",
        altsyncram_component.clock_enable_output_a = "BYPASS",
        altsyncram_component.intended_device_family = "Cyclone V",
        altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
        altsyncram_component.lpm_type = "altsyncram",
        altsyncram_component.numwords_a = 32,
        altsyncram_component.operation_mode = "SINGLE_PORT",
        altsyncram_component.outdata_aclr_a = "NONE",
        altsyncram_component.outdata_reg_a = "UNREGISTERED",
        altsyncram_component.power_up_uninitialized = "FALSE",
        altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
        altsyncram_component.widthad_a = 5,
        altsyncram_component.width_a = 4,
        altsyncram_component.width_byteena_a = 1;


endmodule
