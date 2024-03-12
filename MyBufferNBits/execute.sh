ghdl -a -g --std=08 -fexplicit --ieee=synopsys mybuffernbits.vhd mytbbuffernbits.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 mytbbuffernbits 
ghdl -r -fexplicit --ieee=synopsys --std=08 mytbbuffernbits --wave=mytbbuffernbits.ghw