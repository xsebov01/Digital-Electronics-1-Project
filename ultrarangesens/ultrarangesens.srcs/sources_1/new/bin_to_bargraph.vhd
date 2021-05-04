----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 20:23:01
-- Design Name: 
-- Module Name: bin_to_bargraph - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_to_bargraph is
    Port ( hundreds_i : in STD_LOGIC_VECTOR (3 downto 0);
           tens_i     : in STD_LOGIC_VECTOR (3 downto 0);
           unit_i     : in STD_LOGIC_VECTOR (3 downto 0);
           LED_o      : out STD_LOGIC_VECTOR (3 downto 0));
end bin_to_bargraph;

architecture Behavioral of bin_to_bargraph is

begin
    process(hundreds_i, tens_i, unit_i)
    begin
    
    -- distance is between 0 to 5 cm
    if((to_integer(unsigned(unit_i))) <= 5 and 
       (to_integer(unsigned(tens_i))) = 0  and 
       (to_integer(unsigned(hundreds_i))) = 0) then
        LED_o <= "1111";
    
    -- distance is between 6 to 9 cm
    elsif((to_integer(unsigned(unit_i))) > 5 and (to_integer(unsigned(unit_i))) <= 9 and 
          (to_integer(unsigned(tens_i))) = 0  and 
          (to_integer(unsigned(hundreds_i))) = 0) then
        LED_o <= "0111";
        
    -- distance is between 10 to 49 cm
    elsif((to_integer(unsigned(tens_i))) >= 1 and (to_integer(unsigned(tens_i))) < 5 and
          (to_integer(unsigned(hundreds_i))) = 0) then
        LED_o <= "0011";
        
    -- distance is between 50 to 250 cm
    elsif(((to_integer(unsigned(tens_i))) >= 5 and 
          (to_integer(unsigned(hundreds_i))) = 0) or
          ((to_integer(unsigned(tens_i))) < 5 and
          (to_integer(unsigned(hundreds_i))) <= 2)) then
        LED_o <= "0001";
        
    -- distance is between 250 cm to infinity
    else
        LED_o <= "0000";
    end if;
    
    end process;


end Behavioral;
