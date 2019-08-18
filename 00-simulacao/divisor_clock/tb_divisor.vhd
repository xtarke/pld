-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- Bibliotecas e clásulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY testbench IS
END ENTITY testbench;
------------------------------

ARCHITECTURE stimulus OF testbench IS

    -- Decaclaração do componente
    component divisor_clock is
        port (clk, ena: IN std_logic;
          output: OUT std_logic);
    end component divisor_clock;

    -- declaração de sinais
    signal clk : std_logic := '0';
    signal ena : std_logic := '0';
    signal output : std_logic;


BEGIN  -- inicio do corpo da arquitetura

    -- Instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut: divisor_clock port map (
        clk => clk,
        ena => ena,
        output => output);

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

END ARCHITECTURE stimulus;
