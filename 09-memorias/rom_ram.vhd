-------------------------------------------------------
--! @file
--! @version     : 0.2
--! @brief Simple synchronous memory. Optimized to infer
--         single-port RAM
--         MAX10 needs at least 32 words to infer RAM
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_ram is
	
	port (
		clk : in std_logic;
		addr: in unsigned(4 downto 0);
		-- Must exist to infer RAM.
		we : in std_logic;	
		data_in : in std_logic_vector(6 downto 0);

		q : out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of rom_ram is
	
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(6 downto 0);
	type memory_t is array(0 to 31) of word_t;
	
	-- If 
	function init_rom
	return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
	begin
		for addr_pos in 0 to 31 loop
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 7));
		end loop;
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default initialization value.	
	--signal rom : memory_t := init_rom;
	
	signal rom : memory_t := 
				("1111110", "0110000", "1101101", "1111001",  -- 0, 1, 2, 3
				 "0110011",	"1011011", "0011111", "1110000",  -- 4, 5, 6, 7 
				 "1111111", "1110011", "1110111", "0011111",  -- 8, 9, A, B 
				 "1001110", "0111101", "1001111", "1000111",  -- C, D, E, F
				 others => (others => '0')); 
begin
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if we = '1' then 
				rom(to_integer(addr)) <= data_in;
			end if;
			q <= rom(to_integer(addr));
		end if;
	end process;	
end rtl;