-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity multNbits is
generic (
	N : integer := 4
);
port (
	e1 : in std_logic_vector (N-1 downto 0);
    e2 : in std_logic_vector (N-1 downto 0);
    s1 : out std_logic_vector (2*N-1 downto 0)
);
end multNbits;

architecture multNbits_DataFlow of multNbits is

	signal My_e1 : std_logic_vector (N downto 0);
    signal My_e2 : std_logic_vector (N downto 0);
    signal My_s1 : std_logic_vector (N downto 0);
    
begin
	
    My_e1 <= '0' & e1;
    My_e2 <= '0' & e2;
    
    s1 <= My_s1(N downto 0);
    
    My_s1 <= My_e1 * My_e2;
    
end multNbits_DataFlow;