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
	
	component nios is
		port (
			altpll_0_areset_conduit_export : in    std_logic                     := 'X';             -- export
			altpll_0_locked_conduit_export : out   std_logic;                                        -- export
			clk_clk                        : in    std_logic                     := 'X';             -- clk
			clk_sdram_clk                  : out   std_logic;                                        -- clk
			input_export                   : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			reset_reset_n                  : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr                : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n               : out   std_logic;                                        -- cas_n
			sdram_wire_cke                 : out   std_logic;                                        -- cke
			sdram_wire_cs_n                : out   std_logic;                                        -- cs_n
			sdram_wire_dq                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                 : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n               : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                : out   std_logic;                                        -- we_n
			ouput_export                   : out   std_logic_vector(23 downto 0)                     -- export
		);
	end component nios;
	
	signal clk : std_logic;
	signal clear : std_logic;
	signal w_flag : std_logic;
	signal data_in : std_logic_vector (15 downto 0);
	signal address : unsigned(1 downto 0);
	signal data_out : std_logic_vector (15 downto 0);
	
	
	signal pll_locked : std_logic;
	signal dram_dqm : std_logic_vector(1 downto 0);
	
	signal cpu_input : std_logic_vector(3 downto 0);
	signal cpu_output : std_logic_vector(23 downto 0);
	
	type hex_array_t is array (0 to 5) of std_logic_vector (6 downto 0);
	signal hex_array : hex_array_t;
	
	type data_array_t is array (0 to 5) of unsigned (4 downto 0);	
	signal data_array : data_array_t;
	
	
begin

	-- Note: Quartus 19.1 does not distribute Eclipse anymore. 
	-- Install instructions are included in the <Intel Quartus installation directory>/nios2eds/bin/README.
	
	-- DRAM DQM signals
	DRAM_UDQM <= dram_dqm(1);
	DRAM_LDQM <= dram_dqm(0);
			
	u0 : component nios
		port map (
			altpll_0_areset_conduit_export => '0',
			altpll_0_locked_conduit_export => pll_locked, 
			clk_clk                        => MAX10_CLK1_50,
			clk_sdram_clk                  => DRAM_CLK,
			input_export				   => cpu_input,
			reset_reset_n                  => SW(0),
			sdram_wire_addr                => DRAM_ADDR,
			sdram_wire_ba                  => DRAM_BA,
			sdram_wire_cas_n               => DRAM_CAS_N,
			sdram_wire_cke                 => DRAM_CKE,
			sdram_wire_cs_n                => DRAM_CS_N,
			sdram_wire_dq                  => DRAM_DQ,
			sdram_wire_dqm                 => dram_dqm,
			sdram_wire_ras_n               => DRAM_RAS_N,
			sdram_wire_we_n                => DRAM_WE_N,
			ouput_export                   => cpu_output
			
		);
	
	-- input GPI
	cpu_input <= SW(4 downto 1);
	
	--output gpio
	-- Bit slicing to decode
	data_array(0) <= '0' & unsigned(cpu_output(3 downto 0));
	data_array(1) <= '0' & unsigned(cpu_output(7 downto 4));
	data_array(2) <= '0' & unsigned(cpu_output(11 downto 8));
	data_array(3) <= '0' & unsigned(cpu_output(15 downto 12));
	data_array(4) <= '0' & unsigned(cpu_output(19 downto 16));
	data_array(5) <= '0' & unsigned(cpu_output(23 downto 20));	
	
	-- Binary to 7-segment RAM decoder
	-- Decoder is hardware acelerated
	hex_gen: for i in 0 to 5 generate
		hex_converter: entity work.display_decoder
			port map(
				clk     => MAX10_CLK1_50,
				addr    => data_array(i),
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

