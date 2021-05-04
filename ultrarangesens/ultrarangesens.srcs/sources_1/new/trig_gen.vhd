----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 12:44:45
-- Design Name: 
-- Module Name: trig_gen - Behavioral
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

entity trig_gen is
        Port (		    
            clk     : in STD_LOGIC;     -- Clock
            trig    : out STD_LOGIC     -- Sound wave output
		);
end trig_gen;

architecture Behavioral of trig_gen is
    component pulse_counter is                -- Instantiate Counter component
        generic(
            n: POSITIVE := 10
        );
        port(
            clk_i            : in STD_LOGIC;
            enable_i         : in STD_LOGIC;
            reset_i          : in STD_LOGIC;
            counter_output_o : out STD_LOGIC_VECTOR (n - 1 downto 0)
        );
    end component;
    signal reset_counter    : STD_LOGIC;    -- Reset signal from trigger sensor
    signal output_counter   : STD_LOGIC_VECTOR (24 - 1 downto 0);   -- Calculates the distance in microseconds of the counter
begin
	-- Trigger will be active when the counter has counted 250ms and less than 250ms + 100 us
	-- Due to the configuration of the HC-SR04 Ultrasonic Distance Sensor
	trigger : pulse_counter generic map (24) port map (clk, '1', reset_counter, output_counter);	
	process(clk, output_counter) 
	constant ms250             : STD_LOGIC_VECTOR(24 - 1 downto 0) := "101111101011110000100000";     -- 12500000 ms
 	constant ms250and100us     : STD_LOGIC_VECTOR(24 - 1 downto 0) := "101111101100000000001000";     -- 12501000 ms
	begin
		if(output_counter > ms250 and output_counter < ms250and100us) then
			trig <= '1';
		else
			trig <= '0';
		end if;  
		if(output_counter = ms250and100us or output_counter = "XXXXXXXXXXXXXXXXXXXXXXXX") then
			reset_counter <= '0';
		else
			reset_counter <= '1';
		end if;  
	end process;

end Behavioral;
