library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity files_tb is
	
end entity files_tb;

architecture RTL of files_tb is
	component file_in
		port (dado : out integer range 0 to 100);
	end component file_in;
	
	signal dado : integer;
begin

	dut: component file_in
		port map(
			dado => dado
		);

end architecture RTL;
