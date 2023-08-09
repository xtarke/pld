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
entity testbench_div_cmp is
end entity testbench_div_cmp;
------------------------------

architecture stimulus of testbench_div_cmp is

    component divisor_clock is
        port (clk, ena: IN std_logic;
          output: OUT std_logic);
    end component;



    -- declaração de sinais
    signal clk_tb : std_logic;
    signal ena_tb : std_logic;
    signal output_tb : std_logic;


begin  -- inicio do corpo da arquitetura

    -- instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
   dut: divisor_clock
    port map (
            clk => clk_tb,
            ena => ena_tb,
            output => output_tb
    );

    	
    -- gera um clok
    process
    begin
        clk_tb <= '0';
        wait for 10 ns;
        clk_tb <= '1';
        wait for 10 ns;
    end process;
    
    --gera enable
    process
    begin
        ena_tb <= '0';
        wait for 60 ns;
        ena_tb <= '1';
        wait;
    end process; 

end architecture stimulus;
