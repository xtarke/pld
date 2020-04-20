-------------------------------------------------------------------
-- name        : my_package.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Package creating and operator overload
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package my_package is
	-- Declaração do procedimento
	procedure min_max (signal a,b: in integer range 0 to 15;
		signal min_out, max_out: out integer range 0 to 15);
	
	-- Declaração da função
	function "+" (x, y : std_logic_vector) return std_logic_vector;
end package my_package;

package body my_package is

	-- Corpo do procedimento
	procedure min_max (signal a,b: in integer range 0 to 15;
		signal min_out, max_out: out integer range 0 to 15) is
	begin
		if (a > b) then
			max_out <= a;
			min_out <= b;
		else
			max_out <= b;
			min_out <= a;
		end if;		
	end;

	-- Corpo da função
	function "+" (x, y : std_logic_vector) return std_logic_vector is		
		variable sum : std_logic_vector(x'length-1 downto 0);
		variable carry : std_logic;
	begin
		carry := '0';
		for i in x'reverse_range  loop
			sum(i) :=  x(i) xor y(i) xor carry;
			carry    := (x(i) and y(i)) or (carry and (x(i) or y(i)));
		end loop;

		return sum;
	end "+";

end package body my_package;
