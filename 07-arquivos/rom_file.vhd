-------------------------------------------------------------------
-- name        : basic_rom.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Read-only memory using array
-------------------------------------------------------------------

-- bibliotecas e clásulas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

--! Use standard library
use std.textio.all;


entity rom_file is
  port(address : in  unsigned(3 downto 0); -- valores de 0 a 15
       ce       : in  std_logic;            -- habitita memoria
       output    : out std_logic_vector(31 downto 0));-- saida de dados da memoria
end rom_file ;

architecture teste of rom_file is
	type     RamType is array (natural range 0 to 15) of std_logic_vector(31 downto 0);
	
	function InitRamFromFile(RamFileName : in string) return RamType is
		FILE RamFile : text open read_mode is RamFileName;
		
		variable RamFileLine : line;
		variable RAM : RamType;
		variable hex : std_logic_vector(31 downto 0);
				
	begin
		
		for i in RamType'range loop
			
			if(not endfile(RamFile)) then
        		readline(RamFile, RamFileLine);	-- Faz leirtura da linha
				hread(RamFileLine, hex);		-- Converte texto(em hexdadecimal %x) em std_logic_vector
        	else
        		hex := (others => '0');
      		end if;
			
			--read (RamFileLine, stringRead);			
			--report "Data: " & stringRead;
			
			RAM(i) := hex;			
		end loop;
		
		return RAM;
	
	end function;
	
	signal data : RamType := InitRamFromFile("rom_data.hex"); 
 
   
begin
  output <= data(to_integer(address)) when ce='1' else (others=>'Z');
end teste;