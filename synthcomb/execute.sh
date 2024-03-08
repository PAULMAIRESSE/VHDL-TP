ghdl -a -g --std=08 -fexplicit --ieee=synopsys mymuxnbits2vers1.vhd mysynthcomb.vhd mymultnbits.vhd myaddnbits.vhd mysynthcombtestbench.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 mysynthcombtestbench 
ghdl -r -fexplicit --ieee=synopsys --std=08 mysynthcombtestbench --wave=mySynthcombtestbench.ghw