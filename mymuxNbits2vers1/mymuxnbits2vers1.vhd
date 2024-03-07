-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity muxNbits2vers1 is
generic (
	N : integer := 4
);
port (
	e1 : in std_logic_vector (N-1 downto 0);
    e2 : in std_logic_vector (N-1 downto 0);
    sel : in std_logic;
    s1 : out std_logic_vector (N-1 downto 0)
);
end  muxNbits2vers1;

architecture muxNbits2vers1_DataFlow of muxNbits2vers1 is
	    
begin
	
    -- process explicite - instructions séquentielle
    MyMux2vers1Proc : process (sel, e1, e2)
    begin
    	-- Code du process à compléter
        if sel = '0' then
            s1 <= e1;
        else
            s1 <= e2;
        end if;

    end process;
    
end muxNbits2vers1_DataFlow;