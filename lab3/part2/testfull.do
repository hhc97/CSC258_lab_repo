vlib work
vlog -timescale 1ns/1ns fulladder.v
vsim full
log {/*}
add wave {/*}



force {SW[7]} 0 0 ns, 1 20 ns -repeat 40
force {SW[8]} 0 0 ns, 1 40 ns -repeat 80
force {SW[9]} 0 0 ns, 1 80 ns -repeat 160


run 160ns