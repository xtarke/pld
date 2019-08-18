entity file_in is
  port (dado : out integer range 0 to 100);
end file_in;

architecture teste of file_in is
begin

  le: process
  	
  	type arqv_int is file of integer;
    
    -- VHDL '87    
    --file arquivo_rd: arqv_int is in "dado_a.dat";
    
    -- VHDL '93
    file arquivo_rd  : arqv_int open read_mode is "dado_a.dat";
        
    variable dado_v: integer;

  begin
    while not endfile (arquivo_rd) loop
      read(arquivo_rd, dado_v);
      dado <= dado_v;
      wait for 10 ns;
    end loop;

    wait;
  end process le;
end teste;
