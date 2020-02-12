vlib work
vlog -timescale 1ns/1ns morseout.v
vsim lut
log {/*}
add wave {/*}


force {key[2:0]} 000
run 10 ns
force {key[2:0]} 001
run 10 ns
force {key[2:0]} 010
run 10 ns
force {key[2:0]} 011
run 10 ns
force {key[2:0]} 100
run 10 ns
force {key[2:0]} 101
run 10 ns
force {key[2:0]} 110
run 10 ns
force {key[2:0]} 111
run 10 ns