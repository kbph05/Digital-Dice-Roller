--Display Controller Module: This module will control the LEDs, 
-- 7 segment displays, or LCDs for showing the dice results.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HEXdisplay is
port (SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out std_logic_vector(7 downto 0)
		);
end HEXdisplay;


architecture behaviour of HEXdisplay is
component segDecoder is
		port (
			  D : in  std_logic_vector (3 downto 0);
			  Y : out std_logic_vector (6 downto 0)
		 );
end component;

signal numOfSides : unsigned(3 downto 0);
signal numOfDice : unsigned(3 downto 0);
signal hex_sig : unsigned(6 downto 0);
signal hex_on : std_logic_vector(7 downto 0);


begin

	
 -- Distribute the temporary signal to all HEX outputs
	 HEX0 <= hex_sig;
    HEX1 <= hex_sig;
    HEX2 <= hex_sig;
    HEX3 <= hex_sig;
    HEX4 <= hex_sig;
    HEX5 <= hex_sig;
    HEX6 <= hex_sig;
    HEX7 <= hex_sig;
	 

	numOfHex : configureDice
	port map(
		numOfSides => numOfSides,
		numOfDice => numOfDice
	);
	 
		seg1 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX0
	); 
		seg2 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX1
	);
		seg3 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX2
	);
		seg4 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX3
	);
		seg5 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX4
	);
		seg6 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX5
	);
		seg7 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX6
	);
		seg8 : segDecoder
	port map(
		D => hex_sig,
		Y => HEX7
	);

end behaviour;



