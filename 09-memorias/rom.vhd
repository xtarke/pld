library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	generic (
		DATA_WIDTH : natural := 7;
		ADDR_WIDTH : natural := 5
	);
	port (
		clk : in std_logic;
		addr_a: in natural range 0 to 2**ADDR_WIDTH - 1;
		
		we : in std_logic;
		
		--addr_b: in natural range 0 to 2**ADDR_WIDTH - 1;
		
		
		data_in : in std_logic_vector((DATA_WIDTH -1) downto 0);
		
		
		q_a : out std_logic_vector((DATA_WIDTH -1) downto 0)
		
		
		
		
		--q_b : out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end entity;

architecture rtl of rom is
	
	-- Build a 2-D array type for the ROM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(addr_a'high downto 0) of word_t;
	
	function init_rom
	return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
	begin
		for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
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
				 
				 
	signal addr_reg: natural range 0 to 2**ADDR_WIDTH - 1;
	
	--signal we : std_logic;
	--signal data_in : std_logic_vector((DATA_WIDTH -1) downto 0);
	
	
begin
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if we = '1' then 
				rom(addr_a) <= data_in;
			end if;
			
			addr_reg <= addr_a;		
		end if;
	end process;	
	
	q_a <= rom(addr_reg);	
	
end rtl;