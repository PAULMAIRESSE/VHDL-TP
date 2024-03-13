-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity SynthComb is
generic (
	N : integer := 4
);
port (
	e1 : in std_logic_vector (N-1 downto 0);
    e2 : in std_logic_vector (N-1 downto 0);
    sel : in std_logic;
    c_in: in std_logic;
    s1 : out std_logic_vector (2*N-1 downto 0)
);
end  SynthComb;

architecture SynthComb_DataFlow of SynthComb is
	-- when sel is '0' the output is the sum of e1 and e2, when sel is '1' the output is the multiplication of e1 and e2    

    component addNbits is 
        generic (
            N : integer 
        );
        port (
            e1 : in std_logic_vector (N-1 downto 0);
            e2 : in std_logic_vector (N-1 downto 0);
            s1 : out std_logic_vector (N-1 downto 0);
            c_out : out std_logic;
            c_in : in std_logic
        );
    end component;

    signal my_s_add : std_logic_vector (N-1 downto 0);
    signal my_cout_add : std_logic;

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

    signal my_s_mult : std_logic_vector (2*N-1 downto 0);

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

    signal my_e1_mux, my_e2_mux : std_logic_vector (2*N-1 downto 0) := (others => '0');
    
begin
    
    MyAdder : addNbits
    generic map ( N => N )
    port map (
        e1 => e1,
        e2 => e2,
        s1 => my_s_add,
        c_out => my_cout_add,
        c_in => c_in
    );

    MyMultiplier : MultNbits
    generic map ( N => N )
    port map (
        e1 => e1,
        e2 => e2,
        s1 => my_s_mult
    );

    MyMux : muxNbits2vers1
    generic map ( N => 2*N )
    port map (
        e1 => my_e1_mux,
        e2 => my_e2_mux,
        sel => sel,
        s1 => s1
    );

    my_e2_mux <= my_s_mult;
    my_e1_mux(N-1 downto 0) <= my_s_add;
    my_e1_mux(N) <= my_cout_add;
    my_e1_mux(2*N-1 downto N+1) <= (others => '0');

end SynthComb_DataFlow;