ghdl -a -g --std=08 -fexplicit --ieee=synopsys mysynthsequence.vhd mytbsynthsequence.vhd components/*.vhd
ghdl -e -fexplicit --ieee=synopsys --std=08 SynthSequenceTestBench 
ghdl -r -fexplicit --ieee=synopsys --std=08 SynthSequenceTestBench --wave=mySynthcombtestbench.ghw