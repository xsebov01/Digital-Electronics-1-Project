----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 20:51:50
-- Design Name: 
-- Module Name: tb_bin_to_bargraph - Behavioral
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

entity tb_bin_to_bargraph is
--  Port ( );
end tb_bin_to_bargraph;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_bin_to_bargraph is

    -- Local signals
    signal s_hundreds  :  std_logic_vector(4 - 1 downto 0);
    signal s_tens      :  std_logic_vector(4 - 1 downto 0);
    signal s_unit      :  std_logic_vector(4 - 1 downto 0);
    signal s_LED       :  std_logic_vector(4 - 1 downto 0);

begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_bin_to_bargraph : entity work.bin_to_bargraph
        port map(
            hundreds_i   =>   s_hundreds,
            tens_i       =>   s_tens,
            unit_i       =>   s_unit,
            LED_o        =>   s_LED

        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        s_unit <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";

        s_hundreds <= "0001"; wait for 100 ns;
        
        s_tens <= "1001"; wait for 100 ns;
        
        s_tens <= "0000"; wait for 100 ns;
        
        s_hundreds <= "1001"; wait for 100 ns;
        
        s_tens <= "0011"; wait for 100 ns;
        
        s_hundreds <= "1001"; wait for 100 ns;
        
        s_hundreds <= "0001"; wait for 100 ns;
        
        s_unit <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_tens <= "0011"; s_unit <= "0101"; wait for 100 ns;
        
        s_unit <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_unit <= "0011"; wait for 100 ns;
        
        s_unit <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_unit <= "0111"; wait for 100 ns;
        
        wait;
    end process p_stimulus;

end architecture testbench;