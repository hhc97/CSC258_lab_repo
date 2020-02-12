vlib work
vlog -timescale 1ns/1ns ratecounter.v
vsim ratecounter
log {/*}
add wave {/*}


force {CLOCK_50} 0 0, 1 1 -r 2
force {SW[1:0]} 00
force {SW[2]} 0 0, 1 10

run 2000 ns