vlib work
vlog -timescale 1ns/1ns poly_function.v
vsim part2
log {/*}
add wave {/*}


force {clk} 0 0, 1 5 -r 10

force {resetn} 0 0, 1 10



# A
force {go} 0 0, 1 10
# B
force {go} 0 20, 1 30
# C
force {go} 0 40, 1 50
# x
force {go} 0 60, 1 70
# run
force {go} 0 80, 1 90


# A = 2, B = 3, C = 4, x = 5, out = 117
force {data_in[7:0]} 00000010 0, 00000011 20, 00000100 40, 00000101 60

run 200ns
