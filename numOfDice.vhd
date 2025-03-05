library ieee;
use ieee.std_logic_1164.all;

entity numOfDice is
    Port ( D : in  std_logic_vector (3 downto 0);  
		  enable : in std_logic;
        Y : out std_logic_vector (6 downto 0)
    );
end numOfDice;

architecture SegFunc of numOfDice is

begin

	process(enable, D)
	begin
		if enable = '1' then
			 case D is
				  when "0000" => Y <= "1000000"; -- 0
              when "0001" => Y <= "1111001"; -- 1
				  when "0010" => Y <= "1111001"; -- 1
				  when "0100" => Y <= "1111001"; -- 1
				  when "1000" => Y <= "1111001"; -- 1
				  
              when "0011" => Y <= "0100100"; -- 2
				  when "0101" => Y <= "0100100"; -- 2
				  when "1001" => Y <= "0100100"; -- 2
				  when "1010" => Y <= "0100100"; -- 2
				  when "1100" => Y <= "0100100"; -- 2
				  when "0110" => Y <= "0100100"; -- 2
				  
              when "0111" => Y <= "0110000"; -- 3
				  when "1011" => Y <= "0110000"; -- 3
				  when "1110" => Y <= "0110000"; -- 3
				  
              when "1111" => Y <= "0011001"; -- 4
              when others => Y <= "1111111"; -- Default case (all segments off)
			end case;
		end if;
	end process;
end SegFunc;
