vlib work
vlog -timescale 1ns/1ns counter.v
vsim counter
log {/*}
add wave {/*}


force {SW[1]} 1

force {KEY[0]} 0 0, 1 5 -r 10

force {SW[0]} 1 0, 0 5, 1 10

run 2600 ns
