library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockCounter is
	port (clockIn : in std_logic;
			rollState : inout std_logic := '0';
			numOfSides : in unsigned;
			clockOut : out std_logic
	);		
end clockCounter;

architecture func of clockCounter is

	signal counter : unsigned(19 downto 0) := (others => '0'); -- counter is inside (internal signal)
	begin

	process (counter, clockIn)
	begin
		if rising_edge(clockIn) -- check for rising edge
				then counter <= counter + 1; -- add 1 to counter
				rollState := '1';
		end if;
	end process;
		
	clockOut <= counter(19); -- MSB becomnes output

end func;			