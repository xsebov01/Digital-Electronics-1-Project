library ieee;
use ieee.std_logic_1164.all;

entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    
    signal s_reset      : std_logic;
    
    signal s_units 		: std_logic_vector(4-1 downto 0);
    signal s_tens 		: std_logic_vector(4-1 downto 0);
    signal s_hundreds 	: std_logic_vector(4-1 downto 0);
    
    signal s_dp_i  		: std_logic_vector(4-1 downto 0);
    signal s_dp_o  		: std_logic;
    signal s_seg   		: std_logic_vector(7-1 downto 0);
    
    signal s_dig   		: std_logic_vector(4-1 downto 0);
    

begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
    port map(
            clk     	=> s_clk_100MHz,
            reset   	=> s_reset,
                      
            units_i 	=> s_units,
            tens_i 		=> s_tens,
            hundreds_i 	=> s_hundreds,
            
            dp_i    	=> s_dp_i,
                    
            dp_o    	=> s_dp_o,
            seg_o   	=> s_seg, 
            dig_o   	=> s_dig 
        );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ms loop
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 28 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 53 ns;
       
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_hundreds	<= "0001";
        s_tens 		<= "0100";
        s_units 	<= "0010";
       
        s_dp_i  	<= "1111";
        
        wait for 40 ms;
        
        s_hundreds	<= "0101";
        s_tens 		<= "0110";
        s_units 	<= "0011";
       
        s_dp_i  	<= "1111";
        
        wait for 40 ms;
        
        s_hundreds	<= "0000";
        s_tens 		<= "0000";
        s_units 	<= "0000";
       
        s_dp_i  	<= "1111";
        
        wait for 40 ms;
        
        s_hundreds	<= "0111";
        s_tens 		<= "0010";
        s_units 	<= "1001";
       
        s_dp_i  	<= "1111";
        
        wait for 40 ms;
        
       report "Stimulus process finished" severity note;  
       wait;
      end process p_stimulus; 
        
end architecture testbench;