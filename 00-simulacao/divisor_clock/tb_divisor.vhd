-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------
entity testbench_div is
end entity testbench_div;
------------------------------

architecture stimulus of testbench_div is

    -- declaração de sinais
    signal clk_tb : std_logic;
    signal ena_tb : std_logic;
    signal output_10 : std_logic;
    signal output_5 : std_logic;


begin  -- inicio do corpo da arquitetura

    -- instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut_5: entity work.divisor_clock
        generic map(
            MAX => 5
        )
        port map(
            clk    => clk_tb,
            ena    => ena_tb,
            output => output_5
        );

    dut_10:entity work.divisor_clock
        generic map(
            MAX => 10
        )
        port map(
            clk    => clk_tb,
            ena    => ena_tb,
            output => output_10
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
