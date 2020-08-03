-------------------------------------------------------
--! @file
--! @brief Testbench ilustrando um fila circuilar 
--         implementada por funções e procedimentos.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.fila.all;

entity fila_TB is
	--port(
		--clk : in std_logic;
		--rst : in std_logic
	--);
end entity fila_TB;

architecture RTL of fila_TB is
	signal fila_inst: fila_t;
	signal dado_out: unsigned (7 downto 0);
begin
	process is
	begin
		cria_fila(fila_inst);
		wait for 10 ns;
		
		for i in 0 to 17 loop
			enqueue(to_unsigned(i,8), fila_inst);
			wait for 10 ns;
		end loop;
		
		dequeue(fila_inst, dado_out);
		wait for 10 ns;		
		dequeue(fila_inst, dado_out);
		wait for 10 ns;
		
		enqueue("00100010", fila_inst);
		wait for 10 ns;
		enqueue("00110000", fila_inst);
		wait for 10 ns;
		enqueue("00110011", fila_inst);
		wait for 10 ns;
		dequeue(fila_inst, dado_out);
		wait for 10 ns;
			
		for i in 0 to 15 loop
			dequeue(fila_inst, dado_out);
			wait for 10 ns;
		end loop;
	
		wait;
	end process;
	
	
end architecture RTL;
