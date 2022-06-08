-------------------------------------------------------------------
-- name        : tb_delays.vhd
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
    signal a : std_logic := '0';
    signal inercial : std_logic := '0';
    signal transporte : std_logic := '0';

begin  -- inicio do corpo da arquitetura

    process
    begin
        a <= '0';
        wait for 10 ns;
        a <= '1';
        wait for 40 ns;
        a <= '0';
        wait for 10 ns;
        a <= '1';
        wait;
    end process;
    
    
    process(a) 
    begin
        inercial <= a after 20 ns;
    end process;
    
    process(a) 
    begin
        transporte <= transport a after 20 ns;
    end process;  

end architecture stimulus;
