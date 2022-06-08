-------------------------------------------------------------------
-- Name        : divisor_clock.vhd
-- Author      : Exemplo baseado em PEDRONI, Eletrônica Digital Moderna e VDHL
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de divisor de clock.
-------------------------------------------------------------------

-- bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;

-- entidade e portas
entity divisor_clock is
    generic (
        constant MAX: natural := 5
    );    
    port (clk, ena: in std_logic;
          output: out std_logic);
end entity;

-- arquitetura
architecture rtl of divisor_clock is
    
begin
    p0: process(clk)
        variable count: natural range 0 to MAX := 0;
        variable temp: std_logic := '0';
    begin
        if (rising_edge(clk)) then
            if ena = '1' then
                count := count + 1;
                if (count = MAX) then
                    temp := not temp;
                    count := 0;
                end if;           
            end if;            
        end if;    
        output <= temp;        
    end process;
end architecture;
