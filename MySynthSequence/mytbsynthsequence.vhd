-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity SynthSequenceTestBench is

end SynthSequenceTestBench;

architecture SynthSequenceTestBench_Arch of SynthSequenceTestBench is

	-- Déclaration du composant à tester -> renvoie vers l'entité muxNbits2vers1 !
	component SynthSequence is
    generic (
        N : integer 
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        sel : in std_logic;
        s1 : out std_logic_vector (2*N-1 downto 0);
        c_in : in std_logic
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;

begin
    
end SynthSequenceTestBench_Arch;

