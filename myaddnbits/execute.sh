ghdl -a -g --std=08 -fexplicit --ieee=synopsys myaddnbits.vhd mytbaddnbits.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 myAddNbitstestbench
ghdl -r -fexplicit --ieee=synopsys --std=08 myAddNbitstestbench --wave=myAddNbitstestbench.ghw