vlib work
vlog -timescale 1ns/1ns alulab4.v
vsim alu
log {/*}
add wave {/*}


# the clock input, let it alternate between 1 and 0 every 5 ns
force {KEY[0]} 0 0, 1 5 -r 10

# reset signal, intervals of 10 ns low every 90 ns
force {SW[9]} 0 0, 1 10, 0 90, 1 100, 0 180, 1 190

# three different A values for testing
force {SW[3:0]} 0000 0, 0011 90, 1100 180 -r 270

#  functions, 10ns each:
force {SW[7:5]} 000 00, 001 20, 010 30, 011 40, 100 50, 101 60, 110 70, 111 80 -r 90

run 270ns
