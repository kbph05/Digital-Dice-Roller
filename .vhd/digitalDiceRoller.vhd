library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalDiceRoller is
    Port (
        CLK        : in  STD_LOGIC;
        RESET      : in  STD_LOGIC;
        ROLL       : in  STD_LOGIC;
        SW         : in  STD_LOGIC_VECTOR(17 downto 0); -- 18 switches
        LEDR       : out STD_LOGIC_VECTOR(17 downto 0); -- 18 red LEDs
        HEX0       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 0
        HEX1       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 1
        HEX2       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 2
        HEX3       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 3
        HEX4       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 4
        HEX5       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 5
        HEX6       : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment display 6
        HEX7       : out STD_LOGIC_VECTOR(6 downto 0)   -- 7-segment display 7
    );
end DigitalDiceRoller;

architecture Behavioral of DigitalDiceRoller is

    -- Function to convert a 4-bit number to 7-segment display
    function to_7seg(digit : STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is
    begin
        case digit is
            when "0000" => return "1000000"; -- 0
            when "0001" => return "1111001"; -- 1
            when "0010" => return "0100100"; -- 2
            when "0011" => return "0110000"; -- 3
            when "0100" => return "0011001"; -- 4
            when "0101" => return "0010010"; -- 5
            when "0110" => return "0000010"; -- 6
            when "0111" => return "1111000"; -- 7
            when "1000" => return "0000000"; -- 8
            when "1001" => return "0010000"; -- 9
            when others => return "1111111"; -- Off
        end case;
    end function to_7seg;

    -- Define states for FSM
    type STATE_TYPE is (IDLE, ROLLING, DISPLAY);
    signal state, next_state : STATE_TYPE;

    -- Counters and registers
    signal dice_counter      : integer := 0;
    signal side_counter      : integer := 0;
    signal roll_counter      : integer := 0;
    signal rand_value        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal dice_values       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal random_gen        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    -- Random number generator (simple example)
    process (CLK)
    begin
        if rising_edge(CLK) then
            random_gen <= random_gen + 1;
        end if;
    end process;

    -- FSM Process
    process (CLK, RESET)
    begin
        if RESET = '1' then
            state <= IDLE;
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
    end process;

    -- Next state logic
    process (state, ROLL, roll_counter, random_gen)
    begin
        case state is
            when IDLE =>
                if ROLL = '1' then
                    next_state <= ROLLING;
                else
                    next_state <= IDLE;
                end if;

            when ROLLING =>
                if roll_counter < dice_counter then
                    next_state <= ROLLING;
                else
                    next_state <= DISPLAY;
                end if;

            when DISPLAY =>
                next_state <= IDLE;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- Output Logic
-- Output Logic
process (state, random_gen, roll_counter)
begin
    case state is
        when IDLE =>
            dice_values <= (others => '0');

        when ROLLING =>
            if roll_counter < dice_counter then
                -- Convert random_gen and SW(3 downto 0) to integers for mod operation
                rand_value <= std_logic_vector(to_unsigned(to_integer(random_gen) mod to_integer(SW(3 downto 0)), 8));
                -- Assign the lower 4 bits of rand_value to the corresponding 4-bit slice of dice_values
                dice_values((roll_counter + 1) * 4 - 1 downto roll_counter * 4) <= rand_value(3 downto 0);
                roll_counter <= roll_counter + 1;
            end if;

        when DISPLAY =>
            -- Display the result on the 7-segment displays
            if roll_counter = 0 then
                HEX0 <= to_7seg(dice_values(3 downto 0));
            elsif roll_counter = 1 then
                HEX1 <= to_7seg(dice_values(7 downto 4));
            else
                HEX0 <= "1111111"; -- Off
            end if;

        when others =>
            -- Default case for safety
            HEX0 <= "1111111"; -- Off
            HEX1 <= "1111111"; -- Off
    end case;
end process;

    -- LED indication for dice count (Optional)
	 
    LEDR <= SW;

end Behavioral;


