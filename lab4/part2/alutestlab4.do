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
force {SW[3: 0]} 2#0000 0, 2#0011 90, 2#1100 180 -r 270

#  functions, 10ns each:
force {SW[7: 5]} 2#000 00, 2#001 20, 2#010 30, 2#011 40, 2#100 50, 2#101 60, 2#110 70, 2#111 80 -r 90

run 270ns
