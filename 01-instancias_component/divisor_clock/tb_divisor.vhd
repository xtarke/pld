-------------------------------------------------------------------
-- name        : testbench.vhd
-- author      : renan augusto starke
-- version     : 0.1
-- copyright   : renan, departamento de eletrônica, florianópolis, ifsc
-- description : exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------
entity testbench_div_cmp is
end entity testbench_div_cmp;
------------------------------

architecture stimulus of testbench_div_cmp is

    component divisor_clock is
        port (clk, rst, ena: IN std_logic;
          output: OUT std_logic);
    end component;

    constant N: integer := 16;
    
       -- declaração de sinais
    signal clk_tb : std_logic;
    signal ena_tb : std_logic;
    signal output_tb : std_logic;
    signal output_novo : std_logic;
    signal rst : std_logic;

    signal dataa : unsigned(N-1 downto 0);
    signal datab : unsigned(N-1 downto 0);
    signal sum : unsigned(N-1 downto 0);
 

begin  -- inicio do corpo da arquitetura

    -- instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
adder_inst : entity work.adder
    generic map(
        N => N
    )
    port map(
        dataa => dataa,
        datab => datab,
        sum   => sum
    );
       
    datab <= x"0002";

    process
    begin
        for i in 0 to 24 loop
            dataa <= to_unsigned(i, N);
            wait for 5 ns;
        end loop; 
    end process;


   dut: divisor_clock
    port map (
            rst => rst,
            clk => clk_tb,
            ena => ena_tb,
            output => output_tb
    );

    divisor_clock_inst : entity work.divisor_clock
        port map(
            rst => rst,
            clk    => clk_tb,
            ena    => ena_tb,
            output => output_novo
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

    rst <= '1', '0' after 2 ns;



end architecture stimulus;
