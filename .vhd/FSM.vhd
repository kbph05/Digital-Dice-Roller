library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockProcess is
    port (
        clock_50 : in std_logic;
        w        : in std_logic;
        reset    : in std_logic;
        KEY      : in std_logic_vector(3 downto 0);
        mux      : out std_logic;
        q        : out std_logic
    );
end ClockProcess;

architecture Behavioral of ClockProcess is
    signal internal_q : std_logic := '0';
    signal internal_mux : std_logic := '0';
begin
    process(clock_50)
    begin    
        if rising_edge(clock_50) then
            internal_q <= internal_mux and not KEY(2);
        end if;
    end process;

    process(w, internal_q)
    begin
        if w = '1' then
            internal_mux <= '1';
        else 
            internal_mux <= internal_q;
        end if;
    end process;

    mux <= internal_mux;
    q <= internal_q;
end Behavioral;
