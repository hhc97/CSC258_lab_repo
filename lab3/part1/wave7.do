vlib work
vlog -timescale 1ns/1ns mux7to1.v
vsim mux7to1
log {/*}
add wave {/*}


# Expected output: 1
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns
