-------------------------------------------------------------------
-- Name        : fir.vhd
-- Author      : Renan A. Starke (Exemplo baseado em PEDRONI, Circuit design with VHDL)
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de filtro fir com coeficêntes fixos
-------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir is
    generic (
        N: integer := 4;    --! Número de coeficientes
        M: integer := 8     --! Número de bits das entradas e coeficientes
    );

    port(
        clk : in std_logic; --! Clock
        rst : in std_logic; --! Sinal de reset

        x: in signed(M-1 downto 0); --! Dado de entrada
        y: out signed (2*M-1 downto 0);  --! Dado de saída  
    	y_halfword: out signed(M-1 downto 0)
    );
end entity fir;

architecture RTL of fir is
    type registradores is array (N-2 downto 0) of signed (M-1 downto 0);
    type coeficientes is array (N-1 downto 0) of signed (M-1 downto 0);
    
    signal reg: registradores;
    constant COEF: coeficientes := (x"01", x"01", x"01", x"01");
    
begin
    
    process(clk, rst)
        variable acc,prod : signed(2*M-1 downto 0);
        variable sinal : std_logic;
    begin
        
        if rst = '1' then
            
            -- inicializa todos os registradores
            for i in N-2 downto 0 loop
                reg(i) <= (others => '0');
            end loop;
            
            -- inicializa acumuladores e sinal
            acc := (others => '0');
            prod := (others => '0');
            sinal := '0' ;
            
        elsif rising_edge(clk) then
            acc:= COEF(0) * x;
            
            for i in 1 to N-1 loop
                sinal := acc(2*M - 1);
                prod := COEF(i) * reg(N-1 - i);
                acc := acc + prod;                
                        
                -- Verificação de overflow
                if (sinal=prod(prod'left)) and (acc(acc'left) /= sinal) then
                    acc := (acc'left => sinal, others => not sinal);
                end if;
            end loop;    
            reg <= x & reg(N-2 downto 1);                            
        end if; 
        y <= acc;
 	y_halfword <= shift_right(acc, 2)(7 downto 0);
    end process;

end architecture RTL;
