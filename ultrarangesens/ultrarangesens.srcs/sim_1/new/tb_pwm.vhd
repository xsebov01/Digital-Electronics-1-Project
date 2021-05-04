library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_pwm is
    -- Entity of testbench is always empty  
end tb_pwm;

architecture testbench of tb_pwm is
    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz 	: STD_LOGIC;
	signal s_hundreds 		: STD_LOGIC_VECTOR (3 downto 0);
    signal s_tens    		: STD_LOGIC_VECTOR (3 downto 0);
    signal s_units     		: STD_LOGIC_VECTOR (3 downto 0);
    signal s_alarm 			: STD_LOGIC;
	
begin

uut_pwm : entity work.pwm
        port map(
            clk_i       => s_clk_100MHz,
			hundreds_i  => s_hundreds, 	
			tens_i      => s_tens,	
			unit_i     => s_units,    	
			alarm_o  	=> s_alarm	
        );

    p_clk_gen : process
    begin
        while now < 100 ms loop
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_stimulus : process
    begin
	    s_units <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";

        s_hundreds <= "0001"; wait for 100 us;
        
        s_tens <= "1001"; wait for 100 us;
        
        s_tens <= "0000"; wait for 100 us;
        
        s_hundreds <= "1001"; wait for 100 us;
        
        s_tens <= "0011"; wait for 100 us;
        
        s_hundreds <= "1001"; wait for 100 us;
        
        s_hundreds <= "0001"; wait for 100 us;
        
        s_units <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_tens <= "0011"; s_units <= "0101"; wait for 100 us;
        
        s_units <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_units <= "0011"; wait for 100 us;
        
        s_units <= "0000"; s_tens <= "0000"; s_hundreds <= "0000";
        
        s_units <= "0111"; wait for 100 us;
		
        wait;
    end process p_stimulus;

end testbench; 