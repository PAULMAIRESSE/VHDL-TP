-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity mycomptdecompNbitstestbench is

end mycomptdecompNbitstestbench;

architecture mycomptdecompNbitstestbench_Arch of mycomptdecompNbitstestbench is

	-- Déclaration du composant à tester -> renvoie vers l'entité comptdecompNbits !
	component comptdecompNbits is
    generic ( N : integer );
    port (
        reset : in std_logic;
        clock : in std_logic;
        cpt : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
    end component;

	-- Déclaration de la constante pour le paramètre générique (non obligatoire)
    constant N : integer := 3;
    
    -- Déclaration de la constante permettant de définir la période de l'horloge
    constant PERIOD : time := 100 us;
    
    -- Déclaration des signaux internes à l'architecture pour réaliser les simulations
    signal s1_sim : std_logic_vector(N-1 downto 0) := (others => '0'); 
    signal reset_sim, cpt_sim, clock_sim	: std_logic := '0';
    signal cpt_calc : integer := 0;
    
    -- Déclaration des états de l'automate
    type t_SM_Test is (S0_INITCPT, S1_CPT, S2_INITDCPT, S3_DCPT, S4_END);
    signal r_SM_Test : t_SM_Test := S0_INITCPT;
    signal reset_automate : std_logic := '0';

begin

    -- Gestion des sorties de l'automate
    reset_sim <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S2_INITDCPT or r_SM_Test = S4_END else '0';
    cpt_sim <= '1' when r_SM_Test = S0_INITCPT or r_SM_Test = S1_CPT or r_SM_Test = S4_END else '0';

    -- Instanciation du composant à tester 
    MyComponentsynthcomb01underTest : comptdecompNbits
    --raccordement des ports du composant aux signaux dans l'architecture
    generic map ( N => N )
    port map ( 
        reset => reset_sim,
        cpt => cpt_sim,
        clock => clock_sim,
        s1 => s1_sim
    );
    
	-- -- Définition du process permettant de générer l'horloge pour le test
    -- My_clock_Proc : process -- pas de liste de sensibilité 	
    -- begin
    -- 	clock_sim <= '0';
    --     wait for PERIOD/2;
    --     clock_sim <= '1';
    --     wait for PERIOD/2;
        
    --     if now = (4*N+2*(2**N))*PERIOD then
    --     	wait;
    --     end if;
    
    -- end process;
    


    -- Définition du process d'évolution de l'automate
    myAutomateProc : process (reset_automate, clock_sim)
    begin
        if (reset_automate = '1') then
            r_SM_Test <= S0_INITCPT;
        elsif falling_edge(clock_sim) then
            case r_SM_Test is
                when S0_INITCPT =>
                    r_SM_Test <= S1_CPT;
                when S1_CPT =>
                    if (s1_sim = (2**N)-1) then
                        r_SM_Test <= S2_INITDCPT;
                    else
                        r_SM_Test <= S1_CPT;
                    end if;
                when S2_INITDCPT =>
                    r_SM_Test <= S3_DCPT;
                when S3_DCPT =>
                    if (s1_sim = 0) then
                        r_SM_Test <= S4_END;
                    else
                        r_SM_Test <= S3_DCPT;
                    end if;
                when S4_END =>
                    r_SM_Test <= S4_END;
                when others =>
                    r_SM_Test <= S0_INITCPT;
            end case;
        end if;
    end process;

    -- Définition du process permettant de réinitialiser l'automate
    MyStimulus_Proc2 : process -- pas de liste de sensibilité
    begin
        reset_automate <= '1';
        wait for PERIOD;
        reset_automate <= '0';
        wait;
    end process;

    -- -- Définition du process permettant de réinitialiser l'automate	
    -- MyStimulus_Entries : process -- pas de liste de sensibilité 	
    -- begin
    --    	reset_sim <= '1';
    --     cpt_sim <= '1';
    --     wait for PERIOD;
    --     -- debug state and number of periods
    --     report "reset =" & std_logic'image(reset_sim) & " cpt =" & std_logic'image(cpt_sim) & " s1 =" & integer'image(to_integer(unsigned(s1_sim))) & " at clock n°" & integer'image(now/PERIOD) severity note;
    --     assert (s1_sim = "000") report "Test 1 failed" severity error;
    --     reset_sim <= '0';
    --     cpt_sim <= '1';
    --     for i in 1 to 2**N-1 loop
    --         cpt_calc <= i;
    --         wait for PERIOD;
    --         report "reset =" & std_logic'image(reset_sim) & " cpt =" & std_logic'image(cpt_sim) & " s1 =" & integer'image(to_integer(unsigned(s1_sim))) & " at clock n°" & integer'image(now/PERIOD) severity note;
    --         assert (s1_sim = std_logic_vector(to_unsigned(i, N))) report "Test 2 failed" severity error;
    --     end loop;
    --     reset_sim <= '0';
    --     cpt_sim <= '0';
    --     for i in cpt_calc downto 1 loop
    --         wait for PERIOD;
    --         report "reset =" & std_logic'image(reset_sim) & " cpt =" & std_logic'image(cpt_sim) & " s1 =" & integer'image(to_integer(unsigned(s1_sim))) & " at clock n°" & integer'image(now/PERIOD) severity note;
    --         assert (s1_sim = std_logic_vector(to_unsigned(i-1, N))) report "Test 3 failed" severity error;
    --     end loop;
    --     reset_sim <= '1';
    --     cpt_sim <= '0';
    --     wait for PERIOD;
    --     report "reset =" & std_logic'image(reset_sim) & " cpt =" & std_logic'image(cpt_sim) & " s1 =" & integer'image(to_integer(unsigned(s1_sim))) & " at clock n°" & integer'image(now/PERIOD) severity note;
    --     assert (s1_sim = "000") report "Test 4 failed" severity error;
    --     wait;
    -- end process;
    
end mycomptdecompNbitstestbench_Arch;

