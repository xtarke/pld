library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (
		BITS : integer := 7
	);
	
	port(
		clk : in std_logic;
		rst : in std_logic;		
		value :  out unsigned(BITS downto 0)
	);
end entity counter;

architecture RTL of counter is
	signal data : unsigned(BITS downto 0);
begin
	
	process(clk, rst)
	begin
		if rst = '1' then
			data <= (others => '0');
		elsif rising_edge(clk) then
			data <= data + 1;
		end if;
	end process;
	
	value <= data;
	
end architecture RTL;
