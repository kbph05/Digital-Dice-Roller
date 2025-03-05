library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DisarmSystem is 
port (clock : in std_logic;
		w : in std_logic_vector (1 downto 0);
		disarm : out std_logic;
		sseg0, sseg1, sseg2: out std_logic_vector(6 downto 0)
		); 
end DisarmSystem; 

architecture behaviour of DisarmSystem is

Type state_type is (A,B,C,D);

signal next_state, current_state : state_type;

begin

	process (current_state, W)
		begin
		CASE current_state is
		when A =>
			if (W = "11") then
				next_state <= B;
			else
				next_state <= A;
			end if;
		when B =>
			if (W = "01") then
				next_state <= C;
			else
				next_state <= A;
			end if;
		when C=>        
			if (W = "10") then
				next_state <= D;
			else
				next_state <= A;
			end if;
		when D=>
			next_state <= A;
		 when others =>
			next_state <= A;
		END CASE;
	end process;

	process (clock)
	begin
		if(rising_edge(clock)) then 
			current_state <= next_state; -- current state will become next state
		end if;
	end process;
	
	process (current_state) -- sseg0, 1 and 2 will depend on the current states of the 
    begin
        case current_state is
            when A =>
                sseg2 <= "1111111"; -- Blank
                sseg1 <= "1111111"; -- Blank
                sseg0 <= "1111111"; -- Blank
                disarm <= '0';
            when B =>
                sseg2 <= "1111111"; -- Blank
                sseg1 <= "1111111"; -- Blank
                sseg0 <= "0110000"; -- Display "3"
                disarm <= '0';
            when C =>
                sseg2 <= "1111111"; -- Blank
                sseg1 <= "1111001"; -- Display "1"
                sseg0 <= "0110000"; -- Display "3"
                disarm <= '0';
            when D =>
                sseg2 <= "0100100"; -- Display "2"
                sseg1 <= "1111001"; -- Display "1"
                sseg0 <= "0110000"; -- Display "3"
                disarm <= '1';
            when others =>
                sseg2 <= "1111111"; -- Blank
                sseg1 <= "1111111"; -- Blank
                sseg0 <= "1111111"; -- Blank
                disarm <= '0';
        end case;
    end process;
	
end behaviour;