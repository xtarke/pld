-------------------------------------------------------------------
-- name        : testbench.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Function examples
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Utilização das funções e procedimentos de my_package
use work.my_package.all;

entity testbench is

end entity testbench;

architecture RTL of testbench is
	signal ai : integer range 0 to 15;
	signal bi : integer range 0 to 15;
	signal ci : integer range 0 to 15;
	signal ar : real range 0.0 to 15.0;
	signal br : real range 0.0 to 15.0;
	signal si : integer range 0 to 31;
	signal ti : integer range 0 to 31;
	signal sr : real range 0.0 to 31.0;
	
	signal a_logic : std_logic_vector (3 downto 0);
	signal b_logic : std_logic_vector (3 downto 0);
	signal sum : std_logic_vector (3 downto 0);
	signal som_con : integer range 0 to 15;
	signal sub_con : integer range 0 to 15;
	signal max_out : integer range 0 to 15;
	signal min_out : integer range 0 to 15;
	 
begin

	-- Integer inputs
	ai <= 5, 8 after 10 ns;
	bi <= 7, 2 after 15 ns;
	ci <= 2, 1 after 7 ns;
	
	-- Código possivelmente não sintetizável
	ar <= 2.5, 12.0 after 20 ns;
	br <= 3.4, 9.1 after 12 ns;

	dut: entity work.name_overload
		port map(
			ai => ai,
			bi => bi,
			ci => ci,
			ar => ar,
			br => br,
			si => si,
			ti => ti,
			sr => sr
		);
		
	-- Exemplo overload ("+" para std_logic_vector)
	a_logic <= "0101";
	b_logic <= "0010";		
	sum <= a_logic + b_logic;
	
	soma_sub_dut: entity work.soma_sub_proc
		port map(
			a_i     => ai,
			b_i     => bi,
			c_i     => ci,
			som_con => som_con,
			sub_con => sub_con
		);
		
	min_max(ai, bi, min_out, max_out);

end architecture RTL;
