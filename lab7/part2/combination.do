vlib work
vlog -timescale 1ns/1ns part2.v
vsim combination
log {/*}
add wave {/*}


force {go} 1 0, 0 25 -r 50
force {reset_n} 0 0,1 100
force {clock} 0 0,1 4 -r 8
force {KEY} 1 
force {data_in} 0000001 0, 00000010 10
force {colour} 010 
run 1000ns

force {go} 1 0, 0 25 -r 50
force {reset_n} 1
force {clock} 0 0,1 4 -r 8
force {KEY} 1 0,0 15 -r 30
force {data_in} 00000100 10
force {colour} 3'b010
run 1000ns
