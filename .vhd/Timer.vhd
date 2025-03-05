library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer is
    port (
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        done : out std_logic
    );
end Timer;

architecture Behavioral of Timer is
    signal count : unsigned(31 downto 0) := (others => '0');
    constant COUNT_MAX : integer := 250000 -1; -- 5 seconds at 50 MHz

begin
    process(clock, reset)
    begin
        if reset = '1' then
            count <= (others => '0');
            done <= '0';
        elsif rising_edge(clock) then
            if start = '1' then
                if count = to_unsigned(COUNT_MAX) then
                    done <= '1';
                    count <= (others => '0');
                else
                    count <= count + 1;
                    done <= '0';
                end if;
            else
                count <= (others => '0');
                done <= '0';
            end if;
        end if;
    end process;
end Behavioral;

