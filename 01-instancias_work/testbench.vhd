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

    -- Decaclaração do componente não é necessário em instâncias "work"

    -- declaração de sinais
    signal clk : std_logic := '0';
    signal clear : std_logic := '1';
    signal ena : std_logic := '1';
    signal data : std_logic_vector(15 downto 0) := x"045a";
    signal reg_data : std_logic_vector(15 downto 0);


BEGIN  -- inicio do corpo da arquitetura

    -- Instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma

    registrador_work : entity work.reg16
		port map(
            clk => clk,
            sclr_n  =>  clear,
            clk_ena => ena,
            datain  => data,
            reg_out => reg_data
		);
    
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
