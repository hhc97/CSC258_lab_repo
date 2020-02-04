vlib work
vlog -timescale 1ns/1ns alulab4.v
vsim alu
log {/*}
add wave {/*}


#function 0
#ALUout: 00010000
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 0
#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns


#function 1
#ALUout: 00011110
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1
#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns


#function 2
#ALUout: 00011110 should be same as above test
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0
#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns


#function 3
#ALUout: 11011100
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
#A
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
#B
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 10ns


#function 4
#ALUout: 00000001
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
#A
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
#B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns


#function 5
#ALUout: 10101010
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1
#A
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
#B
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 10ns


#function default
#ALUout: 00000000
force {KEY[2]} 1
force {KEY[1]} 1
force {KEY[0]} 1
#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns
