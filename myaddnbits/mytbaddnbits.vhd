-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity myAddNbitstestbench is

end myAddNbitstestbench;

architecture myAddNbitstestbench_Arch of myAddNbitstestbench is

	-- Déclaration du composant à tester -> renvoie vers l'entité addNbits !
	component addNbits is
    generic (
        N : integer 
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        c_in : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0);
        c_out : out std_logic
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;
    
    -- Déclaration des signaux internes à l'architecture pour réslier les simulations
    signal e1_sim, e2_sim 	: std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal s1_sim 			: std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal c_in_sim, c_out_sim : std_logic := '0';

begin

    MyAddNbits : AddNbits
    generic map (
        N => N
    )
    --raccordement des ports du composant aux signaux dans l'architecture
    port map (
    	e1 => e1_sim,
        e2 => e2_sim,
        c_in => c_in_sim,
        s1 => s1_sim,
        c_out => c_out_sim
    );


    MyStimulus_Proc2 : process -- pas de liste de sensibilité     
    begin
        for i in 0 to (2**N)-1 loop    
            for j in 0 to (2**N)-1 loop
                for k in 0 to 1 loop
                    c_in_sim <= to_unsigned(k,1)(0); 
                    e1_sim <= std_logic_vector(to_unsigned(i,N));
                    e2_sim <= std_logic_vector(to_unsigned(j,N));
                    wait for 100 us;
                    report "c_in=" & integer'image(k) & " | e1=" & integer'image(i) & " | e2=" & integer'image(j) & " || s1 = " & integer'image(to_integer(unsigned(s1_sim))) & " | c_out=" & std_logic'image(c_out_sim);
                    assert s1_sim = (e1_sim + e2_sim + c_in_sim) report "Failure" severity failure;
                end loop;
            end loop;
        end loop;        
        report "Test ok (no assert...)";
        wait;
    end process;

end myAddNbitstestbench_Arch;
