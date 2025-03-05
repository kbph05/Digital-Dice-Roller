library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity random_number is
   Port (
       clk         : in  std_logic;  -- Clock input
		 random_number : out std_logic_vector(7 downto 0);
   );
end random_number;

architecture Behavioral of random_number is

   signal seed : std_logic_vector(7 downto 0) := "00000001";

 -- Random Number Generator
   process(clk)
   begin
      if rising_edge(clk) then
         seed <= seed(6 downto 0) & (seed(7) xor seed(5));
         random_number <= seed;
      end if;
   end process;
	
end behavioural;
