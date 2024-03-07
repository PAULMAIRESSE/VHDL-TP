ghdl -a -g --std=08 -fexplicit --ieee=synopsys mymultnbits.vhd mytbmultnbits.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 myMultNbitstestbench 
ghdl -r -fexplicit --ieee=synopsys --std=08 myMultNbitstestbench --wave=myMultNbitstestbench.ghw