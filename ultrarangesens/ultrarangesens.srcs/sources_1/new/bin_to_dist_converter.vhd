library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_dist_converter is
    port(
        dist_i : 		in  std_logic_vector(9 - 1 downto 0); -- distance (binary)
        hundreds_o : 	out std_logic_vector(4 - 1 downto 0); -- distance hundreds (cm)
        tens_o : 		out std_logic_vector(4 - 1 downto 0); -- distance tens (cm)
        units_o : 		out std_logic_vector(4 - 1 downto 0)  -- distance units (cm)
    );
end entity bin_to_dist_converter;

architecture Behavioral of bin_to_dist_converter is
begin process(dist_i)
  	variable i: integer := 0; -- variable to for-loop
  	variable bcd: std_logic_vector(21 - 1 downto 0);

	begin
  		bcd := (others => '0'); -- set to zero
		bcd(9 - 1 downto 0) := dist_i;
        
		-- Double dabble algorithm (ref: en.wikipedia.org/wiki/Double_dabble)
		for i in 0 to 8 loop
  			bcd(20 - 1 downto 0) := bcd(19 - 1 downto 0) & '0'; -- shift one bit to left
            
            -- add '3' if digit is greater than '4'
			if (i < 8 and bcd(12 downto 9) > "0100") then 
                bcd(12 downto 9) := std_logic_vector( unsigned(bcd(12 downto 9)) + "0011" );
    		end if;
            
            -- add '3' if digit is greater than '4'
    		if (i < 8 and bcd(16 downto 13) > "0100") then 
                bcd(16 downto 13) := std_logic_vector( unsigned(bcd(16 downto 13)) + "0011" );
        	end if;
            
            -- add '3' if digit is greater than '4'
        	if (i < 8 and bcd(20 downto 17) > "0100") then
            	bcd(20 downto 17) := std_logic_vector( unsigned(bcd(20 downto 17)) + "0011" );
            end if;
            
        end loop;

        hundreds_o 	<= bcd(20 downto 17); -- get only hundreds
        tens_o 		<= bcd(16 downto 13); -- get only tens
        units_o		<= bcd(12 downto 9);  -- get only units
        
end process;
end architecture Behavioral;
