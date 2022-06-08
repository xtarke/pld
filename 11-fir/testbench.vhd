-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : testbench para o filtro fir com coeficientes fixos
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
    
end entity testbench;

architecture RTL of testbench is
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal x : signed(7 downto 0);
    signal y : signed (15 downto 0);
    
    type dados is array (7 downto 0) of integer;
    
    constant dado_x : dados := (0,5,10,15,4,9,14,3);
        
begin
    
    clock_driver : process
        constant period : time := 10 ns;
    begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
    end process clock_driver;
    
    rst <= '1', '0' after 3 ns;
    
    dut:entity work.fir
        generic map(
            N => 4,
            M => 8
        )
        port map(
            clk => clk,
            rst => rst,
            x   => x,
            y   => y
        );
        
    dados_entrada:process
    begin
        for i in dados'length-1 downto 0 loop
            x <= to_signed(dado_x(i), 8);
            wait for 10 ns;
        end loop;
        wait;        
    end process;
    
    

end architecture RTL;
