-------------------------------------------------------------------
-- name        : testbench.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Types examples
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench is
end entity testbench;

architecture RTL of testbench is
	
	signal endereco : unsigned(3 downto 0);
	signal ce : std_logic;
	signal saida : unsigned(7 downto 0);
	
	
	signal clk : std_logic;
	signal clear : std_logic;
	signal w_flag : std_logic;
	signal data_in : std_logic_vector (15 downto 0);
	signal address : unsigned(1 downto 0);
	signal data_out : std_logic_vector (15 downto 0);
	 
begin

	ce <= '0', '1' after 5 ns; 
	endereco <= "0000", "0101" after 10 ns, "0111" after 20 ns;
	
	my_rom: entity work.basic_rom
		port map(
			endereco => endereco,
			ce       => ce,
			saida    => saida
		);
	
	
	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	
	clear <= '1', '0' after 5 ns;	
	address <= "10", "11" after 20 ns;
	w_flag <= '0', '1' after 10 ns, '0' after 30 ns;
	data_in <= x"caca";
	
	
	my_registers: entity work.registers
		port map(
			clk      => clk,
			clear    => clear,
			w_flag   => w_flag,
			data_in  => data_in,
			address  => address,
			data_out => data_out
		);	
	

end architecture RTL;
