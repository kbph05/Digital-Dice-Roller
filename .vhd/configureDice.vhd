-- Configuration Module: This module will handle the 
-- input configuration for the number of dice and the number of sides per die.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity configureDice is
port (selection : in std_logic;
		numOfDice : out integer
); 
end configureDice;
		 

architecture behavioural of configureDice is

signal dice_sig : integer;
signal rollState : std_logic := '0';

begin 

	process(selection)
	begin		
		if rollState = '0' then
			if rising_edge(selection) then
				dice_sig <= dice_sig + 1;
			end if;
		end if;		
	end process;
	
end behavioural;