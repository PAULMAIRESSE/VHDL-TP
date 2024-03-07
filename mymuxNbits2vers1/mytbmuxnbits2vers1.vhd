-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity mymuxNbits2vers1testbench is

end mymuxNbits2vers1testbench;

architecture mymuxNbits2vers1testbench_Arch of mymuxNbits2vers1testbench is

	-- Déclaration du composant à tester -> renvoie vers l'entité muxNbits2vers1 !
	component muxNbits2vers1 is
    generic (
        N : integer 
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        sel : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;
    
    -- Déclaration des signaux internes à l'architecture pour réaliser les simulations
    signal e1_sim, e2_sim 	: std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal s1_sim, s1_calc	: std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal sel_sim 			: std_logic := '0';

begin

    -- Instanciation du composant à tester 
    MyComponentMux2vers1underTest : muxNbits2vers1
    --raccordement des ports du composant aux signaux dans l'architecture
    generic map (
    	N => N
    )
    port map ( 
    	e1 => e1_sim,
        e2 => e2_sim,
        sel => sel_sim,
        s1 => s1_sim
    );
    
    -- Intérêt pour la simulation du process implicite ci-dessous ?
    s1_calc <= e1_sim when sel_sim = '0' else e2_sim;
    
    -- Définition du process permettant de faire évoluer les signaux d'entrée du composant à tester	
    MyStimulus_Proc2 : process -- pas de liste de sensibilité 	
    begin
    	
    	for i in 0 to (2**N)-1 loop	
        	for j in 0 to (2**N)-1 loop
            	for k in 0 to 1 loop
                    e1_sim <= std_logic_vector(to_unsigned(i,N));
                  	e2_sim <= std_logic_vector(to_unsigned(j,N));
                    sel_sim <= to_unsigned(k,1)(0);
                    wait for 100 us;
                  	report "sel_in=" & integer'image(k) & " | e1=" & integer'image(i) & " | e2=" & integer'image(j) & " || s1 = " & integer'image(to_integer(unsigned(s1_sim)));
              		assert s1_sim = s1_calc report "Failure" severity failure;
          		end loop;
            end loop;
        end loop;        
        report "Test ok (no assert...)";
        wait;
    end process;
    
end mymuxNbits2vers1testbench_Arch;

