library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalDiceRoller_answerForTestingOnly is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        key : in std_logic_vector(3 downto 0);
        switch : in std_logic_vector(3 downto 0);
        leds : out std_logic_vector(7 downto 0);
        seven_seg : out std_logic_vector(6 downto 0)
    );
end DigitalDiceRoller_answerForTestingOnly;




architecture Behavioral of DigitalDiceRoller_answerForTestingOnly is

    type state_type is (INIT, CONFIG, ROLL, STOP);
    signal current_state, next_state : state_type;
    signal dice_count : unsigned;
    signal sides_count : unsigned;
    signal roll_value : std_logic_vector(3 downto 0);
    signal random_value : unsigned;

begin

    -- State Transition Process
    process (clk, reset)
    begin
        if reset = '1' then
            current_state <= INIT;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State Logic
    process (current_state, key, switch)
    begin
        case current_state is
            when INIT =>
                if key(0) = '1' then
                    next_state <= CONFIG;
                else
                    next_state <= INIT;
                end if;
                
            when CONFIG =>
                if key(1) = '1' then
                    dice_count <= unsigned(switch(3 downto 2));
                    sides_count <= unsigned(switch(1 downto 0));
                    next_state <= ROLL;
                else
                    next_state <= CONFIG;
                end if;
                
            when ROLL =>
                if key(2) = '1' then
                    random_value <= (random_value + 1);
                    roll_value <= std_logic_vector(random_value, 4));
                    next_state <= STOP;
                else
                    next_state <= ROLL;
                end if;
                
            when STOP =>
                if key(3) = '1' then
                    next_state <= INIT;
                else
                    next_state <= STOP;
                end if;
                
            when others =>
                next_state <= INIT;
        end case;
    end process;

    -- Output Logic
    process (current_state, roll_value)
    begin
        case current_state is
            when INIT =>
                leds <= "00000000";
                seven_seg <= "1111111";
            when CONFIG =>
                leds <= "00001111"; -- Indicate configuration mode
                seven_seg <= "0111111"; -- 'C' for config
            when ROLL =>
                leds <= roll_value;
                seven_seg <= "0000001"; -- Display roll in 7-segment format
            when STOP =>
                leds <= roll_value;
                seven_seg <= "1110001"; -- 'S' for stop
            when others =>
                leds <= "00000000";
                seven_seg <= "1111111";
        end case;
    end process;

end Behavioral;
