-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity myMultNbitstestbench is

end myMultNbitstestbench;

architecture myMultNbitstestbench_Arch of myMultNbitstestbench is

	-- Déclaration du composant à tester -> renvoie vers l'entité multNbits !
	component MultNbits is
    generic (
        N : integer 
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        s1 : out std_logic_vector (2*N-1 downto 0)
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;
    
    -- Déclaration des signaux internes à l'architecture pour réslier les simulations
    signal e1_sim, e2_sim 	: std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal s1_sim 			: std_logic_vector(2*N-1 downto 0) := (others => '0'); 

begin

    MyMultNbits : MultNbits
    generic map (
        N => N
    )
    --raccordement des ports du composant aux signaux dans l'architecture
    port map (
    	e1 => e1_sim,
        e2 => e2_sim,
        s1 => s1_sim
    );


    MyStimulus_Proc2 : process -- pas de liste de sensibilité     
    begin
        for i in 0 to (2**N)-1 loop    
            for j in 0 to (2**N)-1 loop
                e1_sim <= std_logic_vector(to_unsigned(i,N));
                e2_sim <= std_logic_vector(to_unsigned(j,N));
                wait for 100 us;
                report "e1=" & integer'image(i) & " | e2=" & integer'image(j) & " || s1 = " & integer'image(to_integer(unsigned(s1_sim)));
                assert s1_sim = (e1_sim * e2_sim) report "Failure" severity failure;
            end loop;
        end loop;        
        report "Test ok (no assert...)";
        wait;
    end process;

end myMultNbitstestbench_Arch;
