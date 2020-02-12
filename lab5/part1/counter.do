vlib work
vlog -timescale 1ns/1ns counter.v
vsim counter_eight_bit
log {/*}
add wave {/*}


force {enable} 1

force {clk} 0 0, 1 5 -r 10

force {clear_b} 1 0, 0 5, 1 10

run 2600 ns
