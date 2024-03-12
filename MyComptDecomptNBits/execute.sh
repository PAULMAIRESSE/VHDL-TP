ghdl -a -g --std=08 -fexplicit --ieee=synopsys mycompdecompnbits.vhd mytbcompdecompnbits_SA.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 mycomptdecompNbitstestbench 
ghdl -r -fexplicit --ieee=synopsys --std=08 mycomptdecompNbitstestbench --wave=mycomptdecompNbitstestbench.ghw