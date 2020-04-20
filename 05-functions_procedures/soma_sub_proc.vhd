-------------------------------------------------------------------
-- name        : soma_sub_proc.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Local procedure example
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_sub_proc is
	port (a_i, b_i, c_i    : in  integer range 0 to 15;
	     som_con, sub_con : out integer range 0 to 15);
end soma_sub_proc;

architecture rtl of soma_sub_proc is

	-- Procedimento soma_sub existe apenas nessa entidade.

	-- Procedimento funciona como código "inline".
	procedure soma_sub( a, b, c : in  integer range 0 to 15;
	                   signal som, sub : out integer range 0 to 15) is
	begin
		som <= a + b;
		sub <= a - c;
	end soma_sub;

begin
	soma_sub(a_i, b_i, c_i, som_con, sub_con);
	
	-- soma_sub pode ser chamado quantas vezes necessário.	
end rtl;
