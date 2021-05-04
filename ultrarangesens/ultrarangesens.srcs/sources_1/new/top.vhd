----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 12:55:22
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           ja : in STD_LOGIC_VECTOR (0 downto 0);
           jb : out STD_LOGIC_VECTOR (4 downto 0);
           jc : out STD_LOGIC_VECTOR (7 downto 0);
           jd : out STD_LOGIC_VECTOR (0 downto 0);
           btn : in STD_LOGIC_VECTOR (0 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

    signal s_trig : std_logic;
    signal s_dist : std_logic_vector (8 downto 0);
    signal s_hundreds : std_logic_vector (3 downto 0);
    signal s_tens : std_logic_vector (3 downto 0);
    signal s_unit : std_logic_vector (3 downto 0);

begin

    --------------------------------------------------------------------
    -- Instance (copy) of distance_calculation entity
    distance_calc : entity work.Distance_calculation
        port map(
		  clk_i               => CLK100MHZ,
		  Calculation_Reset_i => btn(0),
		  pulse_i             => ja(0),
		  Distance_o          => s_dist
        );
    
    --------------------------------------------------------------------
    -- Instance (copy) of trigger_gen entity    
    trig_gen : entity work.trig_gen
        port map(
          clk  => CLK100MHZ,
          trig => jd(0)
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of bin_to_dist entity    
    bin_to_dist : entity work.bin_to_dist_converter
        port map(
          dist_i     => s_dist,
          hundreds_o => s_hundreds,
          tens_o     => s_tens,
          units_o     => s_unit
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of bin_to_bargraph entity    
    bin_to_bar : entity work.bin_to_bargraph
        port map(
          hundreds_i => s_hundreds,
          tens_i     => s_tens,
          unit_i     => s_unit,
          LED_o      => led
        );
    
    pwm : entity work.pwm
      port map(
		clk_i       => CLK100MHZ,
		hundreds_i 	=> s_hundreds,
        tens_i      => s_tens,
        unit_i      => s_unit,
        alarm_o     => jb(4)
       );
        
    --------------------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    driver_7seg_4dig : entity work.driver_7seg_4digits
        port map(
            clk        => CLK100MHZ,
            reset      => btn(0),
            
            hundreds_i => s_hundreds,
            tens_i => s_tens,
            units_i => s_unit,
            
            dp_i => "1111",
            dp_o => jc(7),
            
            seg_o(6) => jc(6),
            seg_o(5) => jc(5),
            seg_o(4) => jc(4),
            seg_o(3) => jc(3),
            seg_o(2) => jc(2),
            seg_o(1) => jc(1),
            seg_o(0) => jc(0),

            dig_o => jb (4-1 downto 0)
            
            
        );


end Behavioral;
