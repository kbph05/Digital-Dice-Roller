Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PreScale_1 is

	port (clockIn : in std_logic;
			clockOut : out std_logic
			);
			
end PreScale_1;

architecture func of PreScale_1 is

signal counter : unsigned(21 downto 0) := (others => '0'); -- counter is inside (internal signal)
begin

process (counter, clockIn)
begin
 
if rising_edge(clockIn) -- check for rising edge
		then counter <= counter + 1; -- add 1 to counter
end if;
	end process;
	
	clockOut <= counter(21); -- MSB becomnes output

end func;			