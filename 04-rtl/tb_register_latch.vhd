-------------------------------------------------------------------
-- name        : tb_register_latch.vhd
-- author      : renan augusto starke
-- version     : 0.1
-- copyright   : renan, departamento de eletrônica, florianópolis, ifsc
-- description : exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------
entity testbench is
end entity testbench;
------------------------------

architecture stimulus of testbench is

    -- declaração de sinais
    signal d : std_logic;
    signal clk : std_logic;
    signal q : std_logic;
    signal data : std_logic;
    signal gate : std_logic;
    signal latch_out : std_logic;

begin  -- inicio do corpo da arquitetura

	
	clock_driver : process
		constant period : time := 5 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
		
	dut: entity work.reg1
		port map(
			clk => clk,
			d => d,
			q => q
		);
		
	latch_1: entity work.latch1
		port map(
			data => d,
			gate => gate,
			q    => latch_out
		);
	
	d <= '0';
	
	-- Estímulos para latch
	gate <= '0', '1' after 20 ns;   
 	 

end architecture stimulus;
