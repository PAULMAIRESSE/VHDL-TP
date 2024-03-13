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
    signal cpt_s1 : std_logic_vector (2*N+1 downto 0);
    signal synth_s1 : std_logic_vector (2*N-1 downto 0);

begin
    
    MyTestAutomate: testAutomate port map (reset, clock, out_reset, out_cpt);

    MyCptDeCpt: comptdecompNbits generic map (2*N+2) port map (out_reset, out_cpt, clock, cpt_s1);

    MySynthComb: SynthComb 
    generic map (2*N+2) 
    port map (
        cpt_s1(0 to N-1),
        cpt_s1(N to 2*N-1),
        cpt_s1(2*N),
        cpt_s1(2*N+1),
        synth_s1
    );

    MyBuffer: bufferNbits generic map (2*N) 
    port map (
        synth_s1,
        reset,
        '0',
        clock,
        s1
    );

end SynthSequence_DataFlow;