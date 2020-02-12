vlib work
vlog -timescale 1ns/1ns ratecounter.v
vsim counter
log {/*}
add wave {/*}


force {clk} 0 0, 1 1 -r 2
force {frequency[1:0]} 01
force {reset_n} 0 0, 1 10

run 2000 ns