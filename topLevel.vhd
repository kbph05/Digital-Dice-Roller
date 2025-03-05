-- Top Module: This is the main file that integrates all the submodules.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topLevel is
port (SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		HEX6, HEX4 : out std_logic_vector(6 downto 0) := "0000000"
		);
end topLevel;
	
	
architecture behaviour of topLevel is

signal rollState : std_logic := '0';
signal numOfSides : unsigned(3 downto 0);
signal numOfDice : unsigned(3 downto 0);
signal valueOfRoll : unsigned(3 downto 0) := "0000";


component segDecoder is
   Port (
        D : in  std_logic_vector (3 downto 0);
        Y : out std_logic_vector (6 downto 0)
    );
end component;



component configureDice is
port (selection : in std_logic_vector(1 downto 0);
		numOfSides : out unsigned;
		numOfDice : out unsigned
		);
end component;


begin
	U3 : configureDice 
	port map(
		selection(1 downto 0) => KEY(3 downto 2),
		numOfSides => numOfSides,
		numOfDice => numOfDice
	);

	 when "00" => display <= "0100100";  -- 0 2
    when "01" => display <= "0011001";  -- 1 4
	 when "10" => display <= "0000010"; -- 2 6 
    when "11" => display <= "0000000";
	 
	
	U1 : segDecoder 
	port map(
		D => std_logic_vector(numOfSides),
		Y => HEX6
	);
	U2 : segDecoder 
	port map(
		D => std_logic_vector(numOfDice),
		Y => HEX4
);
--	U1 : reset 
--	port map(
--			softReset => KEY(0),
--			rollState => rollState,
--			hardReset => KEY(1)
--	);
--	U2 : FSM 
--	port map(
--			clockIn => SW(0),
--			rollState => rollState,
--			clockOut => clock_sig
--	);



end behaviour;