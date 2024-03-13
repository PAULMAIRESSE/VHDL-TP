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
        clock : in std_logic;
        reset: in std_logic;
        s1 : out std_logic_vector (2*N-1 downto 0)
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;
    constant PERIODE : time := 100 ns;

    -- Déclaration des signaux pour la simulation
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal s1_sim : std_logic_vector (2*N-1 downto 0) := (others => '0');

begin

    -- Instanciation du composant à tester
    MySynthSequence : SynthSequence
    generic map (
        N => N
    )
    port map (
        clock => clock,
        reset => reset,
        s1 => s1_sim
    );

    -- Processus pour générer l'horloge
    process
    begin
        wait for PERIODE/2;
        clock <= not clock;

        -- On arrête la simulation
        if now > 2*4*4*(2**N)*PERIODE then
            wait;
        end if;
    end process;

    -- Processus pour générer le reset
    process
    begin
        reset <= '1';
        wait for PERIODE/2;
        reset <= '0';
        wait;
    end process;

    -- debug process
    process
    begin
        wait for PERIODE;
        report "s1 = " & integer'image(to_integer(unsigned(s1_sim)));

        if now > 2*4*4*(2**N)*PERIODE then
            wait;
        end if;
    end process;
    
end SynthSequenceTestBench_Arch;

