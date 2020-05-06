-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de10_lite is 
	port (
		---------- CLOCK ----------
		ADC_CLK_10:	in std_logic;
		MAX10_CLK1_50: in std_logic;
		MAX10_CLK2_50: in std_logic;
		
		----------- SDRAM ------------
		DRAM_ADDR: out std_logic_vector (12 downto 0);
		DRAM_BA: out std_logic_vector (1 downto 0);
		DRAM_CAS_N: out std_logic;
		DRAM_CKE: out std_logic;
		DRAM_CLK: out std_logic;
		DRAM_CS_N: out std_logic;		
		DRAM_DQ: inout std_logic_vector(15 downto 0);
		DRAM_LDQM: out std_logic;
		DRAM_RAS_N: out std_logic;
		DRAM_UDQM: out std_logic;
		DRAM_WE_N: out std_logic;
		
		----------- SEG7 ------------
		HEX0: out std_logic_vector(7 downto 0); 
		HEX1: out std_logic_vector(7 downto 0);
		HEX2: out std_logic_vector(7 downto 0);
		HEX3: out std_logic_vector(7 downto 0);
		HEX4: out std_logic_vector(7 downto 0);
		HEX5: out std_logic_vector(7 downto 0);

		----------- KEY ------------
		KEY: in std_logic_vector(1 downto 0);

		----------- LED ------------
		LEDR: out std_logic_vector(9 downto 0);

		----------- SW ------------
		SW: in std_logic_vector(9 downto 0);

		----------- VGA ------------
		VGA_B: out std_logic_vector(3 downto 0);
		VGA_G: out std_logic_vector(3 downto 0);
		VGA_HS: out std_logic;
		VGA_R: out std_logic_vector(3 downto 0);
		VGA_VS: out std_logic;
	
		----------- Accelerometer ------------
		GSENSOR_CS_N: out std_logic;
		GSENSOR_INT: in std_logic_vector(2 downto 1);
		GSENSOR_SCLK: out std_logic;
		GSENSOR_SDI: inout std_logic;
		GSENSOR_SDO: inout std_logic;
	
		----------- Arduino ------------
		ARDUINO_IO: inout std_logic_vector(15 downto 0);
		ARDUINO_RESET_N: inout std_logic
	);
end entity;


architecture rtl of de10_lite is
	-- Sinais
	signal clk_fast : std_logic;
	signal clk_slow : std_logic;
	signal reset : std_logic;	
	signal counter : unsigned(23 downto 0);
	
	type hex_array_t is array (0 to 5) of std_logic_vector (6 downto 0);
	signal hex_array : hex_array_t;
	
	type counter_array_t is array (0 to 5) of unsigned (4 downto 0);	
	signal counter_array : counter_array_t;
	
	
	
begin
	
	-- PLL IP instance	
	pll_inst: entity work.pll
		port map(
			inclk0 => ADC_CLK_10,
			c0     => clk_slow,
			c1	=> clk_fast
		);
		
	-- counter reset
	reset <= SW(0);
	
	counter_process: process(clk_slow, reset)		
	begin
		if reset = '1' then
			counter <= (others => '0');
		elsif rising_edge(clk_slow) then
			counter <= counter + 1;
		end if;
	end process;
	
	-- Bit slicing to decode
	counter_array(0) <= '0' & counter(3 downto 0);
	counter_array(1) <= '0' & counter(7 downto 4);
	counter_array(2) <= '0' & counter(11 downto 8);
	counter_array(3) <= '0' & counter(15 downto 12);
	counter_array(4) <= '0' & counter(19 downto 16);
	counter_array(5) <= '0' & counter(23 downto 20);	
	
	-- Binary to 7-segment RAM decoder
	hex_gen: for i in 0 to 5 generate
		hex_converter: entity work.rom_ram
			port map(
				clk     => clk_fast,
				addr    => counter_array(i),
				we      => SW(5),
				data_in => (others => '0'),
				q       => hex_array(i)
			);
	end generate;
	
	-- Array to output
	HEX0 <= '1' & hex_array(0);
	HEX1 <= '1' & hex_array(1);
	HEX2 <= '1' & hex_array(2);
	HEX3 <= '1' & hex_array(3);
	HEX4 <= '1' & hex_array(4);
	HEX5 <= '1' & hex_array(5);

end;

