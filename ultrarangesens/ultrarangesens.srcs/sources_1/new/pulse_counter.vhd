----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 11:36:13
-- Design Name: 
-- Module Name: pulse_counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_counter is
    generic (n : positive := 10);
    Port( 
           clk_i            : in  STD_LOGIC;
           enable_i         : in  STD_LOGIC;
           reset_i          : in  STD_LOGIC;                        --Active Low
           counter_output_o : out STD_LOGIC_VECTOR (n - 1 downto 0)
        );
end pulse_counter;

architecture Behavioral of pulse_counter is
    signal s_count   : STD_LOGIC_VECTOR (n - 1 downto 0);
begin
	process(clk_i, reset_i, enable_i)
	begin
		-- Determines the initial values of the count
		if (reset_i = '0') then
			s_count <= (others => '0');
		-- Activates the count when the clock is active AND if enable is active
		elsif(clk_i'event and clk_i = '1') then
			if (enable_i = '1') then
			     s_count <= s_count + 1;
			     end if;
		end if;
	end process;	
	counter_output_o <= s_count;
end Behavioral;
