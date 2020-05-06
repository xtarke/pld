library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Use standard library
use std.textio.all;

--! Funções auxiliares de conversão
use work.txt_util.all;

entity files_tb is	
end entity files_tb;

architecture RTL of files_tb is	
	signal file_in_data : integer;
	signal clk : std_logic;
	signal counter : unsigned(7 downto 0);
	signal endereco : unsigned(3 downto 0);
	signal ce : std_logic;
	signal rom_data : std_logic_vector(31 downto 0);
begin

	-- gera data dado_a.dat
	-- dut_file_out: entity work.file_out;	

	-- lê data dado_a.dat
	dut_file_in: entity work.file_in
		port map(
			dado => file_in_data
	);

	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	
	-- Contador
	counter_process: process(clk)
		variable counter_var : unsigned(7 downto 0) := (others => '0'); 
	begin
		if rising_edge(clk) then
			counter_var := counter_var + 1;
		end if;
		counter <= counter_var;		
	end process;
	
	saida_arquivo: process(clk)
		file my_output : text open WRITE_MODE is "debug.txt";
		variable my_line : line; 
		alias swrite is write [line, string, side, width];
	
	begin
		if (rising_edge(clk)) then
			-- 1) criar a linha com as string. Quantos swrite necessários.
			-- 2) escrever a linha no arquivo.
			
			-- swrite é um alias para trabalhar com string.
			swrite(my_line, str(to_integer(counter), 8));	-- str é uma função definida em work.txt_util
			swrite(my_line, "  tempo: ");
			
			-- existe funções que escrever diretamente na linha.
			write(my_line, now);			
			writeline(my_output, my_line);
		end if;		
	end process;
		
	-- Rom com inicialização externa 
	my_rom_file: entity work.rom_file
		port map(
			address => endereco,
			ce       => ce,
			output    => rom_data
		);
	
	ce <= '0', '1' after 2 ns;	
	endereco <= counter(3 downto 0);
	
	
end architecture RTL;
