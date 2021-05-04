----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2021 18:45:12
-- Design Name: 
-- Module Name: tb_distance_calcs - Behavioral
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

entity tb_distance_calculation is
--  Port ( );
end tb_distance_calculation;

architecture Behavioral of tb_distance_calculation is
constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk               : std_logic;
    signal s_pulse             : std_logic;
    signal s_Calculation_Reset : std_logic;
    signal s_Distance          : std_logic_vector(8 downto 0);
    


begin
uut_Distance_calculator : entity work.Distance_calculation
        port map(
            clk_i               => s_clk,
            pulse_i             => s_pulse, 
            Calculation_Reset_i => s_Calculation_Reset,
            Distance_o          => s_Distance
           
            
        );

p_clk_gen : process
begin
while now < 1000 ns loop         -- 100 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
         end loop;
        wait;
    end process p_clk_gen;


   
p_stimulus :process
    begin
        s_Calculation_Reset <= '1';
        s_pulse <= '0';
        wait for 100ns;
        s_pulse <= '1';
        wait for 100ns;
        s_pulse <= '0';
        wait for 100ns;
        s_pulse <= '1';
        wait for 100ns;

end process p_stimulus;

end Behavioral;
