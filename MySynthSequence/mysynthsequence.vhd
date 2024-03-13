-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity SynthSequence is
generic (
	N : integer := 4
);
port (
    clock : in std_logic;
    reset: in std_logic;
    s1 : out std_logic_vector (2*N-1 downto 0)
);
end  SynthSequence;

architecture SynthSequence_DataFlow of SynthSequence is
	-- when sel is '0' the output is the sum of e1 and e2, when sel is '1' the output is the multiplication of e1 and e2    

    component SynthComb is
    generic (
        N : integer
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        e2 : in std_logic_vector (N-1 downto 0);
        sel : in std_logic;
        c_in: in std_logic;
        s1 : out std_logic_vector (2*N-1 downto 0)
    );
    end component SynthComb;

    component bufferNbits is
    generic (
        N : integer
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        reset : in std_logic;
        preset : in std_logic;
        clock : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
    end component bufferNbits;
    
    component comptdecompNbits is
    generic (
        N : integer
    );
    port (
        reset : in std_logic;
        cpt : in std_logic;
        clock : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
    end component comptdecompNbits;

    component testAutomate is
    port (
        reset : in std_logic;
        clock : in std_logic;
        cpt : out std_logic;
        out_reset : out std_logic
    );
    end component testAutomate;

    signal out_reset, out_cpt : std_logic;
    signal cpt_s1 : std_logic_vector (2*N+2-1 downto 0);
    signal synth_s1 : std_logic_vector (2*N-1 downto 0);
    signal synth_e1, synth_e2 : std_logic_vector (N-1 downto 0);
    signal synth_sel, synth_c_in : std_logic;

begin
    
    MyTestAutomate: testAutomate 
    port map (
        reset => reset, 
        clock => clock, 
        cpt => out_cpt, 
        out_reset => out_reset
    );

    MyCptDeCpt: comptdecompNbits 
    generic map (2*N+2)
    port map (
        reset => out_reset, 
        cpt => out_cpt, 
        clock => clock, 
        s1 => cpt_s1
    );

    synth_e1 <= cpt_s1(N-1 downto 0);
    synth_e2 <= cpt_s1(2*N-1 downto N);
    synth_sel <= cpt_s1(2*N);
    synth_c_in <= cpt_s1(2*N+1);

    MySynthComb: SynthComb 
    generic map (N) 
    port map (
        e1 => synth_e1,
        e2 => synth_e2,
        sel => synth_sel,
        c_in => synth_c_in,
        s1 => synth_s1
    );

    MyBuffer: bufferNbits 
    generic map (2*N) 
    port map (
        e1 => synth_s1,
        reset => reset,
        preset => '0',
        clock => clock,
        s1=>s1
    );

end SynthSequence_DataFlow;