entity file_out is
	
end entity file_out;

architecture RTL of file_out is

begin

	-- processo de escrita
	escreve: process	
		
		type arqv_int is file of integer;
		-- VHDL '87 
		-- file arquivo_wr : arqv_int is out "dado_a.dat";
		
		-- VHDL '93
		file arquivo_wr  : arqv_int open write_mode is "dado_a.dat";	
		
	begin   
	    for dado in 48 to 57 loop
			write (arquivo_wr, dado);
		end loop;
		wait;
	end process escreve;

end architecture RTL;
