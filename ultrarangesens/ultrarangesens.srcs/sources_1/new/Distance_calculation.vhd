library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Distance_calculation is
	port(
		clk_i               : in std_logic; 
		Calculation_Reset_i : in std_logic; --Reset will be active at low level
		pulse_i             : in std_logic; --Trigger pulse input
		Distance_o          : out std_logic_vector(8 downto 0) --Output of the distance calculation
	);
end Distance_calculation;

architecture Behavioral of Distance_calculation is-- Instantiate Counter component
component pulse_counter is
	generic(n: POSITIVE := 10);
	port(
		clk_i           : in std_logic;
		enable_i        : in std_logic;
		reset_i         : in std_logic;
		counter_output_o: out std_logic_vector(n-1 downto 0)
		
	);
end component;


signal Pulse_width              : STD_LOGIC_VECTOR(21 downto 0);
signal not_Calculation_Reset    : std_logic;
signal s_enable                 : std_logic;

begin

not_Calculation_Reset <= not Calculation_Reset_i;

Counter_pulse : pulse_counter generic map(22) 
port map(
		clk_i            => clk_i,
		enable_i         => pulse_i,
		reset_i          => not_Calculation_Reset,
		counter_output_o => pulse_width
	);
    
	Distance_calculator : process(pulse_i)
		--Use the shift and subtract method to divide Pulse by 58, or which transforms
		--numbers from nanoseconds to seconds, according to the sensor's Data Sheet
		variable Result     : integer; --Temporary vector to be multiplied
		variable Multiplier : STD_LOGIC_VECTOR(23 downto 0);
		begin
			if(pulse_i = '0') then
				
				Multiplier := Pulse_width * "11"; --Multiply the vector by 3
				
				Result := to_integer(unsigned(Multiplier(23 downto 13))); --Multiply the most significant bits by 3, and place them in Result
				
				if(Result > 450) then -- If Result reaches the maximum value, Distance will be "111111111"
					Distance_o <= "111111111";
				else
					Distance_o <= STD_LOGIC_VECTOR(to_unsigned(Result,9)); --If not, Distance will be the value of Result placed in a vector of 9 positions
				end if;
			end if;
		end process;
end architecture;