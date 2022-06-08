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
entity testbench is
end entity testbench;
------------------------------

architecture stimulus of testbench is

    -- declaração de sinais
    signal clk : std_logic;
    signal ena : std_logic;
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
            clk    => clk,
            ena    => ena,
            output => output_5
        );

    dut_10:entity work.divisor_clock
        generic map(
            MAX => 10
        )
        port map(
            clk    => clk,
            ena    => ena,
            output => output_10
        );


    -- gera um clok
    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    --gera enable
    process
    begin
        ena <= '0';
        wait for 60 ns;
        ena <= '1';
        wait;
    end process;

end architecture stimulus;
