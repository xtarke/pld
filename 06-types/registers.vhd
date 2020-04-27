-------------------------------------------------------------------
-- name        : registers.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Component instatiation using generate
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
	port (
		clk 	: in std_logic;
		clear	: in std_logic;
		w_flag	: in std_logic;
		data_in	: in std_logic_vector (15 downto 0);
		address : in unsigned(1 downto 0);
		data_out: out std_logic_vector (15 downto 0)		
	);
end entity;


architecture RTL of registers is
	
	type reg_array is array (0 to 3) of std_logic_vector (15 downto 0);
	signal registers : reg_array;
	
	signal w_flag_encoder : std_logic_vector(3 downto 0);
	
	signal clear_n : std_logic;
begin
	
	clear_n <= not clear;
	
	-- gera três componentes: observem reg_out
	reg_gen: for i in 0 to 3 generate
		regs: entity work.reg16
			port map (
				clk => clk,
				sclr_n => clear_n,
				clk_ena => w_flag_encoder(i),
				datain => data_in,
				reg_out => registers(i)
			);
	end generate;
	
	-- Multiplexador de saída
	data_out <= registers(to_integer(address));
	
	-- Codificador do w_enable
	process(w_flag, address)
	begin
		w_flag_encoder <= (others =>'0');	
		w_flag_encoder(to_integer(address)) <= w_flag;
	end process;	
	
	
end architecture RTL;