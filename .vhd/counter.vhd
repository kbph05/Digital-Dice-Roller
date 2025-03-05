Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (add_clock, display_clock, initialize, reset : in std_logic;
		add_amount_top : in std_logic_vector(6 downto 0);
		output : out std_logic_vector(2 downto 0)
		);
end counter;

architecture func of counter is

	component add_var is 
		port (add_amount : in std_logic_vector(6 downto 0);
				pause_int, reset_int, clk: in std_logic;
				random_value : out std_logic_vector(2 downto 0)
				);
	end component;

	signal output_internal : std_logic_vector(2 downto 0);
	signal trigger : std_logic;
	signal countdown : unsigned(4 downto 0) := "00000";
	signal countdown_logic : std_logic_vector(4 downto 0);

	begin

	addVar : add_var port map(
		add_amount => add_amount_top,
		clk => add_clock,
		random_value => output_internal,
		pause_int => trigger,
		reset_int => reset
	);

	countdown_logic <= std_logic_vector(countdown);
	trigger <= (countdown_logic(0) or countdown_logic(1) or countdown_logic(2) or countdown_logic(3) or countdown_logic(4));
	
	process is
	begin
		wait until display_clock = '1';
		output <= output_internal;
	end process;
	
	process is
	begin
		wait until ((display_clock = '1' and trigger = '1') or (initialize = '1'));
		countdown <= resize(countdown + "1", 5);
	end process;
	
end func;
