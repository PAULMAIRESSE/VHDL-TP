-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity testAutomate is
port (
	reset : in std_logic;
    clock : in std_logic;
    cpt : out std_logic;
    out_reset : out std_logic
);
end  testAutomate;

architecture testAutomate_Arch of testAutomate is
begin
	
    out_reset <= reset;
    cpt <= '1';
    
end testAutomate_Arch;