Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCDCount2_1 is
port (clear, enable, clock, stop : in std_logic;
		bcd0, bcd1, bcd2, bcd3, bcd4, bcd5, bcd6, bcd7 : out std_logic_vector(3 downto 0)
		);
end BCDCount2_1;


architecture func of BCDCount2_1 is

	component Count4 is
		port (d : in std_logic_vector(3 downto 0);
				enable, load, clock : in std_logic;
				q : out std_logic_vector(3 downto 0)
				);
	end component;
	
	 signal andGate, orGate : std_logic_vector(7 downto 0) := (others => '0');
    signal q0, q1, q2, q3, q4, q5, q6, q7 : std_logic_vector(3 downto 0) := (others => '0');
    signal count : integer range 0 to 6 := 0;
	
begin
	process(clock)
		 begin
		 if clear = '1' and stop = '0' then
			count <= 0;
		 elsif rising_edge(clock) then
			if enable = '1' then
				if count = 6 then
					count <= 0;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
	end process;
	
	 -- Assign count to BCD outputs
    --bcd0 <= std_logic_vector(to_unsigned(count, 4));
    bcd1 <= std_logic_vector(to_unsigned(count, 4));
    --bcd2 <= std_logic_vector(to_unsigned(count, 4));
    bcd3 <= std_logic_vector(to_unsigned(count, 4));
    --bcd4 <= std_logic_vector(to_unsigned(count, 4));
    --bcd5 <= std_logic_vector(to_unsigned(count, 4));
    --bcd6 <= std_logic_vector(to_unsigned(count, 4));
    --bcd7 <= std_logic_vector(to_unsigned(count, 4));

end func;