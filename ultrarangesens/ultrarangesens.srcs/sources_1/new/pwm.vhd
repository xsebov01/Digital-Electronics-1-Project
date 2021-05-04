library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    port(
		clk_i       :   in std_logic;
		hundreds_i 	: 	in STD_LOGIC_VECTOR (3 downto 0);
        tens_i     	: 	in STD_LOGIC_VECTOR (3 downto 0);
        unit_i     	: 	in STD_LOGIC_VECTOR (3 downto 0);
        alarm_o 	:   out std_logic
    );
end entity pwm;

architecture Behavioral of pwm is

    -- Internal clock enable
    signal s_en     : std_logic;
    -- Local delay counter
    signal s_cnt    : unsigned(4 - 1 downto 0);
    
    type t_state is (st_distance_0_5,
					st_distance_6_9,	
					st_distance_10_49,	
					st_distance_50_249,
					st_distance_250_inf
					);
	
    -- Define the signal that uses different states
    signal s_state  : t_state;

    -- Specific values for local counter
    constant c_DELAY_3SEC : unsigned(4 - 1 downto 0) := b"0011";
    constant c_DELAY_2SEC : unsigned(4 - 1 downto 0) := b"0010";
    constant c_DELAY_1SEC : unsigned(4 - 1 downto 0) := b"0001";
    constant c_ZERO       : unsigned(4 - 1 downto 0) := b"0000";


begin

    p_alarm_fsm : process(hundreds_i, tens_i, unit_i)
    begin                 			
		-- distance is between 0 to 5 cm
		if((to_integer(unsigned(unit_i))) <= 5 and 
		   (to_integer(unsigned(tens_i))) = 0 and 
		   (to_integer(unsigned(hundreds_i))) = 0) then
			s_state <= st_distance_0_5;
		
		-- distance is between 6 to 9 cm
		elsif((to_integer(unsigned(unit_i))) > 5 and (to_integer(unsigned(unit_i))) <= 9 and 
			  (to_integer(unsigned(tens_i))) = 0 and 
			  (to_integer(unsigned(hundreds_i))) = 0) then
			s_state <= st_distance_6_9;
			
		-- distance is between 10 to 49 cm
		elsif((to_integer(unsigned(tens_i))) >= 1 and (to_integer(unsigned(tens_i))) < 5 and
			  (to_integer(unsigned(hundreds_i))) = 0) then
			s_state <= st_distance_10_49;
			
		-- distance is between 50 to 249 cm
		elsif(((to_integer(unsigned(tens_i))) >= 5 and 
			  (to_integer(unsigned(hundreds_i))) = 0) or
			  ((to_integer(unsigned(tens_i))) < 5 and
			  (to_integer(unsigned(hundreds_i))) <= 2)) then
			s_state <= st_distance_50_249;
			
		-- distance is between 250 cm to infinity
		else
			s_state <= st_distance_250_inf;
		end if;
        
    end process p_alarm_fsm;
    
    p_alarm  :   process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            case s_state is
                when st_distance_0_5 =>
					alarm_o <= '1';      
                when st_distance_6_9 =>
                    if((s_cnt >= c_DELAY_1SEC) and s_cnt < (2*c_DELAY_1SEC)) then
                         s_cnt <= s_cnt + 1;
                         alarm_o <= '0';  
					elsif (s_cnt < c_DELAY_1SEC) then
                        s_cnt <= s_cnt + 1;
                        alarm_o <= '1';
                    else
                        s_cnt <= c_ZERO;
                    end if;        
                when st_distance_10_49 =>
                    if((s_cnt >= c_DELAY_2SEC) and s_cnt < (2*c_DELAY_2SEC)) then
                         s_cnt <= s_cnt + 1;
                         alarm_o <= '0';  
					elsif (s_cnt < c_DELAY_2SEC) then
                        s_cnt <= s_cnt + 1;
                        alarm_o <= '1';
                    else
                        s_cnt <= c_ZERO;
                    end if;      
				when st_distance_50_249 =>
                    if((s_cnt >= c_DELAY_3SEC) and s_cnt < (2*c_DELAY_3SEC)) then
                         s_cnt <= s_cnt + 1;
                         alarm_o <= '0';  
					elsif (s_cnt < c_DELAY_3SEC) then
                        s_cnt <= s_cnt + 1;
                        alarm_o <= '1';
                    else
                        s_cnt <= c_ZERO;
                    end if;    					
                when st_distance_250_inf =>
                    alarm_o <= '0';     
            end case;  
        end if;  
    end process p_alarm;
end architecture Behavioral; 