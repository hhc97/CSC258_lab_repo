vlib work
vlog -timescale 1ns/1ns morseout.v
vsim morseout
log {/*}
add wave {/*}

# selection, load_n, clk, reset_n
force {SW[2:0]} 111

force {CLOCK_50} 0 0, 1 5 -r 10

force {KEY[1]} 1 0, 0 40, 1 60

force {KEY[0]} 1 0, 0 10, 1 30

run 1000 ns