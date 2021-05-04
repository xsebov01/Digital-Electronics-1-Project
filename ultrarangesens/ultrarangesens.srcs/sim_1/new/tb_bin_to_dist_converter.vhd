library ieee;
use ieee.std_logic_1164.all;

entity tb_bin_to_dist_converter is
end entity tb_bin_to_dist_converter;

architecture testbench of tb_bin_to_dist_converter is

    signal s_dist		: std_logic_vector(9 - 1 downto 0);
    signal s_hundreds	: std_logic_vector(4 - 1 downto 0);
    signal s_tens		: std_logic_vector(4 - 1 downto 0);
    signal s_units		: std_logic_vector(4 - 1 downto 0);

begin
    uut_bin_to_dist_converter : entity work.bin_to_dist_converter
        port map(
            dist_i     	=> s_dist,
            hundreds_o 	=> s_hundreds,
            tens_o		=> s_tens,
            units_o    	=> s_units
        );

    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

		 s_dist <= "000000100";
        wait for 100 ns;
        assert ((s_hundreds = "0000") and (s_tens = "0000") and (s_units = "0100"))
        report "Test failed 000001111 -> 0000 0000 0100 (4)" severity error;
        
        s_dist <= "000001111";
        wait for 100 ns;
        assert ((s_hundreds = "0000") and (s_tens = "0001") and (s_units = "0101"))
        report "Test failed 000001111 -> 0000 0001 0101 (15)" severity error;
        
        s_dist <= "100100101";
        wait for 100 ns;
        assert ((s_hundreds = "0010") and (s_tens = "1001") and (s_units = "0011"))
        report "Test failed 100100101 -> 0010 1001 0011 (293)" severity error;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
