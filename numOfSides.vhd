library ieee;
use ieee.std_logic_1164.all;

entity numOfSides is
    Port (
        D : in  std_logic_vector (6 downto 0);  -- 4-bit input for digits 0-F
		  enable : in std_logic;
        Y : out std_logic_vector (6 downto 0)   -- 7-segment display output
    );
end numOfSides;

architecture SegFunc of numOfSides is

begin

	process(enable, D)
	begin
		if enable = '1' then
			 case D is
				  when "0000000" => Y <= "1000000"; -- 0		  
              when "0000001" => Y <= "1111001"; -- 1
              when "0000011" => Y <= "0100100"; -- 2
              when "0000111" => Y <= "0110000"; -- 3
              when "0001111" => Y <= "0011001"; -- 4
				  when "0011111" => y <= "0010010"; -- 5
				  when "0111111" => Y <= "0000010"; -- 6
				  when "1111111" => Y <= "1111000"; -- 7
              when others => Y <= "1111111"; -- Default case (all segments off)
			end case;
		end if;
	end process;
end SegFunc;
