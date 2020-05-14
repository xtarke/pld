-------------------------------------------------------
--! @file
--! @version     : 0.2
--! @brief Simple synchronous memory. Optimized to infer
--         single-port RAM
--         MAX10 needs at least 32 words to infer RAM
-------------------------------------------------------

--! Use IEE standard library
library ieee;
	--! Use standard logic elements
	use ieee.std_logic_1164.all;
	--! Use conversion functions
	use ieee.numeric_std.all;
	--! Use read hex and io functions


entity display_decoder is
	port (
		clk : in std_logic;
		addr: in unsigned(4 downto 0);
		-- Must exist to infer RAM.
		we : in std_logic;	
		data_in : in std_logic_vector(6 downto 0);

		q : out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of display_decoder is
	
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(6 downto 0);
	type memory_t is array(0 to 31) of word_t;
	
	-----------------------------------------	
	-- Initialize memory with constant values
	-- Does work with Quartus
	signal rom : memory_t := 
					("1000000", "1111001", "0100100", "0110000",  -- 0, 1, 2, 3
					 "0011001",	"0010010", "0000010", "1111000",  -- 4, 5, 6, 7 
					 "0000000", "0010000", "0001000", "0000011",  -- 8, 9, A, B 
					 "0100111", "0100001", "0000110", "0001110",  -- C, D, E, F
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