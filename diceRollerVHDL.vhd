library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity diceRollerVHDL is
   Port (
       hard_reset  : in  std_logic; -- Hard reset
       soft_reset  : in  std_logic;  -- Soft reset
       roll_key    : in  std_logic;  -- Roll button
       config_key  : in  std_logic;  -- Configuration button
       num_dice    : in std_logic_vector(2 downto 0); -- Number of dice (3 bits for simplicity)
       num_sides   : in  std_logic_vector(2 downto 0); -- Number of sides per die (3 bits for up to 8 sides)
       sides_out, numDice_out : out std_logic_vector(6 downto 0);
       dice_out    : out std_logic_vector(63 downto 0) -- Output for dice values (3 dice * 8 bits)
   );
end diceRollerVHDL;

architecture Behavioral of diceRollerVHDL is

component random_number is
   Port (
       clk         : in  std_logic;  -- Clock input
		 random_number : out std_logic_vector(7 downto 0);
   );
end component;


   type state_type is (IDLE, SETUP, ROLLING, DONE);
   signal current_state, next_state : state_type;
   signal numOfSides, numOfDice : std_logic_vector(2 downto 0);
   signal dice_stopped : std_logic_vector(7 downto 0);
   signal rolling_values : std_logic_vector(63 downto 0);
   


begin

   -- State Machine Process
   process(clk, hard_reset)
   begin
      if hard_reset = '1' then
         current_state <= IDLE;
         counter <= 0;
         dice_stopped <= (others => '0');
         rolling_values <= (others => '0');
         numOfSides <= (others => '0');
         numOfDice <= (others => '0');
      elsif rising_edge(clk) then
         if soft_reset = '1' then
            current_state <= IDLE;
         else
            current_state <= next_state;
         end if;
      end if;
   end process;

   -- State Transition Logic
   process(current_state, roll_key, config_key, dice_stopped)
   begin
      case current_state is
         when IDLE =>
            if config_key = '1' then
               next_state <= SETUP;
            else
               next_state <= IDLE;
            end if;

         when SETUP =>
            if roll_key = '1' then
               next_state <= ROLLING;
            else
               next_state <= SETUP;
            end if;

         when ROLLING =>
            if dice_stopped = "11111111" then
               next_state <= DONE;
            else
               next_state <= ROLLING;
            end if;

         when DONE =>
            if soft_reset = '1' then
               next_state <= IDLE;
            else
               next_state <= DONE;
            end if;

         when others =>
            next_state <= IDLE;
      end case;
   end process;

   -- Output Logic
   process(current_state)
   begin
      case current_state is
         when IDLE =>
            rolling_values <= (others => '0');
            dice_stopped <= "00000000";

         when SETUP =>
            numOfSides <= num_sides;
            numOfDice <= num_dice;

            -- Use separate processes for signal assignments
            
               case num_sides is
                  when "000" => sides_out <= "1111001";
                  when "001" => sides_out <= "0100100";
                  when "010" => sides_out <= "0110000";
                  when "011" => sides_out <= "0011001";
                  when "100" => sides_out <= "0010010";
                  when "101" => sides_out <= "0000010";
                  when "110" => sides_out <= "1111000";
                  when others => sides_out <= "0000000";
               end case;

            
               case num_dice is
                  when "000" => numDice_out <= "1111001";
                  when "001" => numDice_out <= "0100100";
                  when "010" => numDice_out <= "0110000";
                  when "011" => numDice_out <= "0011001";
                  when "100" => numDice_out <= "0010010";
                  when "101" => numDice_out <= "0000010";
                  when "110" => numDice_out <= "1111000";
                  when others => numDice_out <= "0000000";
               end case;

         
         when ROLLING =>
            if counter < 1000000 then
               counter <= counter + 1;
            else
               counter <= 0;
            end if;

            for i in 0 to 7 loop
               if i < to_integer(unsigned(numOfDice)) then
                  if dice_stopped(i) = '0' then
                     rolling_values(8*(i+1)-1 downto 8*i) <= random_number;
                  elsif (to_integer(unsigned(random_number)) mod to_integer(unsigned(numOfSides)) = 0) then
                     dice_stopped(i) <= '1';
                  end if;
               end if;
            end loop;

         when DONE =>
            for i in 0 to 7 loop
               dice_out(8*(i+1)-1 downto 8*i) <= random_number;
            end loop;

         when others =>
            random_number <= (others => '0');
      end case;
   end process;

end Behavioral;


