-------------------------------------------------------------------
-- name        : de0_lite.vhd
-- author      : 
-- version     : 0.1
-- copyright   : departamento de eletrônica, florianópolis, ifsc
-- description : projeto base de10-lite
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de10_lite is 
	port (
		---------- clock ----------
		adc_clk_10:	in std_logic;
		max10_clk1_50: in std_logic;
		max10_clk2_50: in std_logic;
		
		----------- sdram ------------
		dram_addr: out std_logic_vector (12 downto 0);
		dram_ba: out std_logic_vector (1 downto 0);
		dram_cas_n: out std_logic;
		dram_cke: out std_logic;
		dram_clk: out std_logic;
		dram_cs_n: out std_logic;		
		dram_dq: inout std_logic_vector(15 downto 0);
		dram_ldqm: out std_logic;
		dram_ras_n: out std_logic;
		dram_udqm: out std_logic;
		dram_we_n: out std_logic;
		
		----------- seg7 ------------
		hex0: out std_logic_vector(7 downto 0);
		hex1: out std_logic_vector(7 downto 0);
		hex2: out std_logic_vector(7 downto 0);
		hex3: out std_logic_vector(7 downto 0);
		hex4: out std_logic_vector(7 downto 0);
		hex5: out std_logic_vector(7 downto 0);

		----------- key ------------
		key: in std_logic_vector(1 downto 0);

		----------- led ------------
		ledr: out std_logic_vector(9 downto 0);

		----------- sw ------------
		sw: in std_logic_vector(9 downto 0);

		----------- vga ------------
		vga_b: out std_logic_vector(3 downto 0);
		vga_g: out std_logic_vector(3 downto 0);
		vga_hs: out std_logic;
		vga_r: out std_logic_vector(3 downto 0);
		vga_vs: out std_logic;
	
		----------- accelerometer ------------
		gsensor_cs_n: out std_logic;
		gsensor_int: in std_logic_vector(2 downto 1);
		gsensor_sclk: out std_logic;
		gsensor_sdi: inout std_logic;
		gsensor_sdo: inout std_logic;
	
		----------- arduino ------------
		arduino_io: inout std_logic_vector(15 downto 0);
		arduino_reset_n: inout std_logic
	);
end entity;


architecture rtl of de10_lite is
    signal clk : std_logic;
    signal rst : std_logic;
    signal x : signed(7 downto 0);
    signal y : signed (15 downto 0);
begin
	
	
	dut:entity work.fir
        generic map(
            N => 4,
            M => 8
        )
        port map(
            clk => adc_clk_10,
            rst => SW(0),
            x   => x,
            y   => y
        );
	
	arduino_io <= std_logic_vector(y);
	x <= signed(dram_dq(7 downto 0));
	
	
end;

