-------------------------------------------------------------------
-- name        : testbench.vhd
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
    signal clk : std_logic := '0';
    signal ena : std_logic := '0';
    signal output : std_logic;


begin  -- inicio do corpo da arquitetura

    -- instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut: entity work.divisor_clock
    	port map(
    		clk    => clk,
    		ena    => ena,
    		output => output
    	);
    	
    -- gera um clok
    process
    begin
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        clk <= '1';    
    end process;
    
    --gera enable
    process
    begin
        wait for 60 ns;
        ena <= '1';           
        wait;
    end process; 

end architecture stimulus;
