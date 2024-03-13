-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity MultNbits is
generic (
	N : integer := 4
);
port (
	e1 : in std_logic_vector (N-1 downto 0);
    e2 : in std_logic_vector (N-1 downto 0);
    s1 : out std_logic_vector (2*N-1 downto 0)
);
end MultNbits;

architecture multNbits_DataFlow of MultNbits is
begin
    
    s1 <= std_logic_vector(unsigned(e1) * unsigned(e2));
    
end multNbits_DataFlow;