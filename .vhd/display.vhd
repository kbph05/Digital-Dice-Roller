library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display is
   Port (
       KEY : in std_logic_vector(3 downto 0);
       SW : in std_logic_vector(17 downto 0);
       HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX5 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX6 : out STD_LOGIC_VECTOR(6 downto 0);
       HEX7 : out STD_LOGIC_VECTOR(6 downto 0)
   );
end display;

architecture func of display is

   component diceRollerVHDL is
      port (
         clk         : in  std_logic;  -- Clock input
         hard_reset  : in  std_logic;  -- Hard reset
         soft_reset  : in  std_logic;  -- Soft reset
         roll_key    : in  std_logic;  -- Roll button
         config_key  : in  std_logic;  -- Configuration button
         num_dice    : in  std_logic_vector(2 downto 0); -- Number of dice (3 bits for simplicity)
         num_sides   : in  std_logic_vector(2 downto 0); -- Number of sides per die (3 bits for up to 8 sides)
         sides_out   : out std_logic_vector(6 downto 0);
         numDice_out : out std_logic_vector(6 downto 0);
         dice_out    : out std_logic_vector(63 downto 0) -- Output for dice values (3 dice * 8 bits)
      );
   end component;

   component SegDecoder is
      Port (
         D : in  std_logic_vector (6 downto 0);
         Y : out std_logic_vector (6 downto 0)
      );
   end component;

   signal dice_values : std_logic_vector(63 downto 0);

begin

   -- Instantiate diceRollerVHDL component
   U1 : diceRollerVHDL
      port map (
         clk => KEY(3),
         soft_reset => KEY(2),
         hard_reset => KEY(1),
         roll_key => KEY(0),
         config_key => SW(17),
         num_dice => SW(2 downto 0),
         num_sides => SW(5 downto 3),
         dice_out => dice_values,
         sides_out => HEX6,
         numDice_out => HEX7
      );

   -- Instantiate SegDecoder components for displaying dice values
   S1 : SegDecoder
      port map (
         D => dice_values(6 downto 0),
         Y => HEX0
      );

   S2 : SegDecoder
      port map (
         D => dice_values(13 downto 7),
         Y => HEX1
      );

   S3 : SegDecoder
      port map (
         D => dice_values(20 downto 14),
         Y => HEX2
      );

   S4 : SegDecoder
      port map (
         D => dice_values(27 downto 21),
         Y => HEX3
      );

   S5 : SegDecoder
      port map (
         D => dice_values(34 downto 28),
         Y => HEX4
      );

   S6 : SegDecoder
      port map (
         D => dice_values(41 downto 35),
         Y => HEX5
      );

   S7 : SegDecoder
      port map (
         D => dice_values(48 downto 42),
         Y => HEX6
      );

   S8 : SegDecoder
      port map (
         D => dice_values(55 downto 49),
         Y => HEX7
      );

end func;

	  