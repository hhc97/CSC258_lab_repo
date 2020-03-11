vlib work
vlog -timescale 1ps/1ps ram32x4.v
vsim -L altera_mf_ver ram32x4
log {/*}
add wave {/*}


force {address} 00101 0, 01010 50, 00101 100, 01010 150
force {clock} 0 0, 1 10 -r 20
force {data} 1010 0, 0101 60, 0000 100
force {wren} 1 0, 0 100
run 200ps
