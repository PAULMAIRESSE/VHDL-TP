-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity addNbits is
generic (
	N : integer := 4
);
port (
	e1 : in std_logic_vector (N-1 downto 0);
    e2 : in std_logic_vector (N-1 downto 0);
    c_in : in std_logic;
    s1 : out std_logic_vector (N-1 downto 0);
    c_out : out std_logic
);
end addNbits;

architecture addNbits_DataFlow of addNbits is

	signal My_e1 : std_logic_vector (N downto 0);
    signal My_e2 : std_logic_vector (N downto 0);
    signal My_c_in : std_logic_vector (N downto 0);
    signal My_s1 : std_logic_vector (N downto 0);
    
begin
	
    My_e1 <= '0' & e1;
    My_e2 <= '0' & e2;
    My_c_in(N downto 1) <= (others => '0');
    My_c_in(0) <= c_in;
    
    s1 <= My_s1(N-1 downto 0);
    c_out <= My_s1(N);
    
    My_s1 <= My_e1 + My_e2 + My_c_in;
    
end addNbits_DataFlow;