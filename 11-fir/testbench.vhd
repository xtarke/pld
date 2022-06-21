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
use ieee.std_logic_textio.all;

--! Use standard library
use std.textio.all;

entity testbench is

end entity testbench;

architecture RTL of testbench is

    -- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(0 to 4017) of word_t;

    --------------------------------------------------------
    -- Reads data from a file using text.io    
	function InitRamFromFile(RamFileName : in string) return memory_t is
		FILE RamFile : text open read_mode is RamFileName;

		variable RamFileLine : line;
		variable RAM : memory_t;
		variable data : word_t;

	begin
		for i in memory_t'range loop

			if(not endfile(RamFile)) then
				readline(RamFile, RamFileLine);
				hread(RamFileLine, data);
			else
				data := (others => '0');
			end if;

			RAM(i) := data;
		end loop;

		return RAM;
	end function;

	signal dados_arquivo : memory_t := InitRamFromFile("teste440_2000.hex");

	signal clk : std_logic;
	signal rst : std_logic;
	signal x : signed(7 downto 0);
	signal y : signed (15 downto 0);
	signal y_8bit : signed (7 downto 0);

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

	rst <= '1', '0' after 6 ns;

	dut:entity work.fir
	generic map(
			   N => 4,
			   M => 8
		   )
	port map(
			clk => clk,
			rst => rst,
			x   => x,
			y   => y,
			y_halfword => y_8bit
		);

    --    dados_estaticos:process
    --    begin
    --        for i in dados'length-1 downto 0 loop
    --            x <= to_signed(dado_x(i), 8);
    --            wait for 10 ns;
    --        end loop;
    --        wait;
    --    end process;

	processo_dados_arquivo: process
		variable contador : integer := 0;
	begin
		for i in dados_arquivo'range loop
			x <= signed(dados_arquivo(i));
			contador := contador + 1;
			wait for 10 ns;
		end loop;
		
		-- wait;

		assert false report "End of simulation" severity failure;
	end process;

	process(clk, rst)
		file arquivo_saida : TEXT open WRITE_MODE is "saida.hex";

		variable minha_linha : line; 
	begin
		if rst = '1' then
		elsif rising_edge(clk) then
			hwrite(minha_linha, std_logic_vector(y_8bit));
			writeline(arquivo_saida, minha_linha);	
		end if;
	end process;
end architecture RTL;
