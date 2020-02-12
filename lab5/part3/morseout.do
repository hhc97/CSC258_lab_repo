vlib work
vlog -timescale 1ns/1ns morseout.v
vsim shifter
log {/*}
add wave {/*}


force {load_vals[13:0]} 10101010100000

force {clk} 0 0, 1 5 -r 10

force {load_n} 1 0, 0 20, 1 40

force {reset_n} 1 0, 0 150, 1 151

run 500 ns