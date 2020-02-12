vlib work
vlog -timescale 1ns/1ns morseout.v
vsim morse
log {/*}
add wave {/*}

# selection, load_n, clk, reset_n
force {selection[2:0]} 110

force {clk} 0 0, 1 5 -r 10

force {load_n} 1 0, 0 40, 1 60

force {reset_n} 1 0, 0 10, 1 30

run 1000 ns