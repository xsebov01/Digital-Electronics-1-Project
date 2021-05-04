----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 13:14:40
-- Design Name: 
-- Module Name: tb_trig_gen - Behavioral
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
use IEEE.NUMERIC_STD.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_trig_gen is
    -- Entity of testbench is always empty
end tb_trig_gen;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture Behavioral of tb_trig_gen is
    --Local signals
    signal clock        : STD_LOGIC;
    signal trigger_o    : STD_LOGIC;
    
begin
uut: entity work.trig_gen 
    port map
        (clk => clock, 
        trig => trigger_o
    );
    
--------------------------------------------------------------------
-- Clock generation process
--------------------------------------------------------------------
  stimulus : process
        begin
          clock <= '0';
          wait for 15 ns;
          clock <= '1';
          wait for 15 ns;
  end process; 
end Behavioral;
