-- Reset Controller Module: This module will handle the soft and hard reset functionality


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset is
	port (softReset : in std_logic;
			rollState : inout std_logic;
			hardReset : in std_logic
	); 
end reset;



architecture func of reset is 

	signal hexDisplays : std_logic_vector(7 downto 0);
	signal numOfSides, numOfDice : std_logic;

	begin

	process(hexDisplays)
	begin
		if hardReset = '1' then
			hexDisplays <= (others => '0');
			numOfSides <= '0';
			numOfDice <= '0';
			rollState <= '0';
		elsif softReset = '1' then
			hexDisplays <= (others => '0');
			rollState <= '0';
		end if;
	end process;

	
end func;






