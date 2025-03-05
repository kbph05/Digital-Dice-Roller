library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HexDisplayMapper is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        dice_values  : in  std_logic_vector(63 downto 0);
        hex_display  : out std_logic_vector(6 downto 0) -- Output for hex display
    );
end HexDisplayMapper;

architecture Behavioral of HexDisplayMapper is
    -- Hex display segments for digits 0-9 and A-F
    function to_hex_display(value : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        case value is
            when "0000" => return "1111110"; -- 0
            when "0001" => return "0110000"; -- 1
            when "0010" => return "1101101"; -- 2
            when "0011" => return "1111001"; -- 3
            when "0100" => return "0110011"; -- 4
            when "0101" => return "1011011"; -- 5
            when "0110" => return "1011111"; -- 6
            when "0111" => return "1110000"; -- 7
            when "1000" => return "1111111"; -- 8
            when "1001" => return "1111011"; -- 9
            when "1010" => return "1110111"; -- A
            when "1011" => return "0011111"; -- b
            when "1100" => return "1001110"; -- C
            when "1101" => return "0111101"; -- d
            when "1110" => return "1001111"; -- E
            when "1111" => return "1000111"; -- F
            when others => return "0000000"; -- Default (off)
        end case;
    end function;
    
begin
    process(clk, reset)
    begin
        if reset = '1' then
            hex_display <= (others => '0');
        elsif rising_edge(clk) then
            -- Map dice values to hex displays
            for i in 0 to 7 loop
                -- Example: map each die to a separate 7-segment display (simplified)
                hex_display <= to_hex_display(dice_values(4*i+3 downto 4*i));
            end loop;
        end if;
    end process;
end Behavioral;
