-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- Bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------
entity testbench is
end entity testbench;
------------------------------

architecture stimulus of testbench is

    -- declaração de sinais
    signal clk : std_logic;
    signal rst : std_logic;
    signal x   : std_logic;
    signal y   : std_logic;
    signal z   : std_logic_vector(7 downto 0);


begin  -- inicio do corpo da arquitetura

    -- gera uma forma de onda repetitiva e regular: clocks
    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    --gera uma forma de onda de um só pulso
    process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 50 ns;
        wait;
    end process;

    -- gera uma forma de onda não repetitiva irregular
    process
        constant wave: std_logic_vector(0 to 7) := "10110100";
    begin
        for i in wave'range loop
            x <= wave(i);
            wait for 50 ns;
        end loop;
        wait;
    end process;

    -- gera uma forma de onda repetitiva irregular
    process
        constant wave: std_logic_vector(0 to 7) := "10110100";
    begin
        for i in wave'range loop
            y <= wave(i);
            wait for 50 ns;
        end loop;
    end process;

    -- gera uma forma de onda multibit
    process
    begin
        z <= (z'range => '0');
        wait for 120 ns;

        z <= "11001001";
        wait for 30 ns;

        z <= x"12";
        wait for 60 ns;

        z <= x"cc";
        wait for 120 ns;
    end process;


end architecture stimulus;