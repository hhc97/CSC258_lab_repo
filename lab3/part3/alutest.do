vlib work
vlog -timescale 1ns/1ns alu.v
vsim alu
log {/*}
add wave {/*}

force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1

#B
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
#a
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

force {SW[8]} 0
run 10ns