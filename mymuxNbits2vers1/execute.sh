ghdl -a -g --std=08 -fexplicit --ieee=synopsys mymuxnbits2vers1.vhd mytbmuxnbits2vers1.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 mymuxNbits2vers1testbench 
ghdl -r -fexplicit --ieee=synopsys --std=08 mymuxNbits2vers1testbench --wave=myMultNbitstestbench.ghw