vlib work
vlog -timescale 1ns/1ns shifter.v
vsim shifter
log {/*}
add wave {/*}


# force clock to tick regularly every 5 ns
force {KEY[0]} 0 0, 1 5 -r 10

# have 10ns intervals of reset_n at 0
force {SW[9]} 0 0, 1 10 -r 100


# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 0 0, 1 20 -r 100
# KEY[3] = ASR
force {KEY[3]} 0 0, 1 100 -r 200

run 200ns
