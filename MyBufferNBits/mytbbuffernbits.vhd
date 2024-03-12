-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity mytbbuffernbits is

end mytbbuffernbits;

architecture mytbbuffernbits_Arch of mytbbuffernbits is

	-- Déclaration du composant à tester -> renvoie vers l'entité BufferNBits !
    component bufferNbits is
        generic (
            N : integer := 4
        );
        port (
            e1 : in std_logic_vector (N-1 downto 0);
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            s1 : out std_logic_vector (N-1 downto 0)
        );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 4;

    -- Déclaration de la constante permettant de définir la période de l'horloge
    constant PERIOD : time := 50 us;
    
    -- Déclaration des signaux internes à l'architecture pour réaliser les simulations
    signal e1_sim : std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal s1_sim : std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal s1_calc : std_logic_vector(N-1 downto 0) := (others => '0');
    signal reset_sim, preset_sim, clock_sim : std_logic := '0';

begin

    -- Instanciation du composant à tester 
    MyComponentbufferNbits01underTest : bufferNbits
    --raccordement des ports du composant aux signaux dans l'architecture
    generic map (
    	N => N
    )
    port map ( 
    	e1 => e1_sim,
        reset => reset_sim,
        preset => preset_sim,
        clock => clock_sim,
        s1 => s1_sim
    );
    
	-- Définition du process permettant de générer l'horloge pour le test
    My_clock_Proc : process -- pas de liste de sensibilité 	
    begin
    	clock_sim <= '0';
        wait for 0.8*PERIOD/2;
        clock_sim <= '1';
        wait for 0.2*PERIOD/2;
        
        if now = (8*(2**N))*PERIOD then
        	wait;
        end if;
    
    end process;

    -- My_clock_Proc2 : process -- 20% duty cycle clock
    -- begin
    -- 	clock_sim <= '0';
    --     wait for 0.2*PERIOD/2;
    --     clock_sim <= '1';
    --     wait for 0.8*PERIOD/2;
        
    --     if now = (8*(2**N))*PERIOD then
    --     	wait;
    --     end if;
    
    -- end process;
    
    -- Définition du process permettant de faire évoluer les signaux d'entrée du composant à tester	
    MyStimulus_Proc2 : process -- pas de liste de sensibilité 	
    begin
    	
    	for i in 0 to 1 loop	
        	for j in 0 to 1 loop
            	for k in 0 to (2**N)-1 loop
                   	e1_sim <= std_logic_vector(to_unsigned(k,N));
               		preset_sim <= to_unsigned(j,1)(0);
                    reset_sim <= to_unsigned(i,1)(0);

                    s1_calc <= (others => '0');
                    if (reset_sim = '1') then
                        s1_calc <= (others => '0');
                    elsif (preset_sim = '1') then
                        s1_calc <= (others => '1');
                    else 
                        s1_calc <= e1_sim;
                    end if;
                 	wait for 2*PERIOD;
                    report "reset = " & integer'image(i) & " | preset = " & integer'image(j) & " | e1 = " & integer'image(k) & " || s1 = " & integer'image(to_integer(unsigned(s1_sim)));
                    assert (s1_sim = s1_calc) report "Error" severity error;
                end loop;
            end loop;
        end loop;        
        report "Test done";
        wait;
        
    end process;
    
end mytbbuffernbits_Arch;
