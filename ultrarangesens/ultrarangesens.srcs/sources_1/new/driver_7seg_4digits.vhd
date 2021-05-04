library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     	: in  std_logic;
        reset   	: in  std_logic;
        -- 4-bit input values for individual digits
        units_i 	: in  std_logic_vector(4 - 1 downto 0);
        tens_i 		: in  std_logic_vector(4 - 1 downto 0);
        hundreds_i 	: in  std_logic_vector(4 - 1 downto 0);
        -- 4-bit input value for decimal points
        dp_i    	: in  std_logic_vector(4 - 1 downto 0);
        -- Decimal point for specific digit
        dp_o    	: out std_logic;
        -- Cathode values for individual segments
        seg_o   	: out std_logic_vector(7 - 1 downto 0);
        -- Common anode signals to individual displays
        dig_o   	: out std_logic_vector(4 - 1 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(2 - 1 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(4 - 1 downto 0);

begin
    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse every 4 ms
    --------------------------------------------------------------------
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 400000
        )
        port map(
            clk 	=> clk,
            reset 	=> reset,
            ce_o 	=> s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit down counter
    --------------------------------------------------------------------
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 2
        )
        port map(
            clk 		=> clk,
            reset 		=> reset,
            en_i 		=> s_en,
            cnt_up_i 	=> '0',
            cnt_o		=> s_cnt
        );

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment display decoder
    --------------------------------------------------------------------
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );

    --------------------------------------------------------------------
    -- p_mux:
    --------------------------------------------------------------------
    p_mux : process(s_cnt, units_i, tens_i, hundreds_i, dp_i)
    begin
        case s_cnt is
            when "11" =>
                s_hex <= "0000";
                dp_o  <= dp_i(3);
                dig_o <= "0111";

            when "10" =>
                s_hex <= hundreds_i;
                dp_o  <= dp_i(2);
                dig_o <= "1011";
            when "01" =>
                s_hex <= tens_i;
                dp_o  <= dp_i(1);
                dig_o <= "1101";

            when others =>
                s_hex <= units_i;
                dp_o  <= dp_i(0);
                dig_o <= "1110";
        end case;
    end process p_mux;

end architecture Behavioral;
