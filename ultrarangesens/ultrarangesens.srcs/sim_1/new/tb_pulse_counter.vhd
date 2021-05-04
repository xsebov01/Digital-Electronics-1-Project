----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 12:40:48
-- Design Name: 
-- Module Name: tb_pulse_counter - Behavioral
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
------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_pulse_counter is
    -- Entity of testbench is always empty
end tb_pulse_counter;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture Behavioral of tb_pulse_counter is
  
  --Local signals
  signal clock      : STD_LOGIC;
  signal enb        : STD_LOGIC;
  signal rst        : STD_LOGIC;
  signal count_t    : STD_LOGIC_VECTOR(10 - 1  downto 0);
  
begin
uut: entity work.pulse_counter 
    port map( 
            clk_i => clock, 
            reset_i => rst, 
            enable_i => enb, 
            counter_output_o => count_t
            );
--------------------------------------------------------------------
-- Clock generation process
--------------------------------------------------------------------
  stimulus: process
    begin
      clock <= '0';
      wait for 100000 ns;
      clock <= '1';
      wait for 100000 ns;
      
  end process;

--------------------------------------------------------------------
-- Reset generation process
--------------------------------------------------------------------
  reset: process
    begin
      rst <= '0';
      wait for 20 ns;
      rst <= '1';
      wait;

      wait;
  end process;
  
--------------------------------------------------------------------
-- Enable generation process
--------------------------------------------------------------------
  enable: process
    begin
      enb <= '1';
      wait for 50 ns;    
      
  end process; 
end Behavioral;
