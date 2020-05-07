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
use ieee.numeric_std.all;

-------------------------------------
entity testbench is
end entity testbench;
------------------------------

architecture stimulus of testbench is
    -- declaração de sinais
    signal clk : std_logic := '0';
    signal addr : unsigned(4 downto 0);    
    signal data : std_logic_vector(6 downto 0);

begin  -- inicio do corpo da arquitetura

    -- instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut : entity work.rom_ram
		port map(
            clk => clk,
            addr  => addr,
            we => '0',
            data_in  => "0000000",
            q => data
		);

	-- Laço de teste
    addr_gen: process
    begin
        for i in 0 to 31 loop
            addr <= to_unsigned(i,5);
            wait for 20 ns;
        end loop;
        wait;
    end process;

    -- clock
    process
    begin
		clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;            
    end process;
    
end architecture stimulus;