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

    -- declaração de sinais
    signal clk : std_logic := '1';
    signal rst : std_logic := '0';
    signal x   : std_logic := '0';
    signal y   : std_logic := '0';    
    signal z   : std_logic_vector(7 downto 0); 


BEGIN  -- inicio do corpo da arquitetura

    -- gera uma forma de onda repetitiva e regular: cloks
    process
    begin
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';    
    end process;
    
    --gera uma forma de onda de um só pulso
    process
    begin
        wait for 20 ns;
        rst <= '1';
        wait for 50 ns;
        rst <= '0';    
        wait;
    end process;
    

    -- gera uma forma de onda não repetitiva irregular
    process
        constant wave: std_logic_vector(1 to 8) := "10110100";
    begin
        for i in wave'range loop
            x <= wave(i);
            wait for 50 ns;
        end loop;
        wait;
    end process;
    
     -- gera uma forma de onda repetitiva irregular
    process
        constant wave: std_logic_vector(1 to 8) := "10110100";
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
        
        z <= x"CC";
        wait for 120 ns;
    end process;  
    

END ARCHITECTURE stimulus;
 
