library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rom is

	port
	(
		enable  : in std_logic;	
		rd     : in std_logic;
		
		addr	: in std_logic_vector(7 downto 0);
		clk	: in std_logic;
		q		: out std_logic_vector(15 downto 0)
	);
	
end entity;

architecture rtl of rom is

	-- Build a 2-D array type for the RoM
	subtype word_t is std_logic_vector(15 downto 0);
	type memory_t is array(255 downto 0) of word_t;
		
--	function init_rom
--		return memory_t is
--		variable tmp : memory_t := (others => (others => '0'));
--		begin
--			for addr_pos in 0 to 255 loop
--				-- Initialize each address with the address itself
--				tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 16));
--			end loop;
--		return tmp;
--	end init_rom;
	
	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	constant rom: memory_t := (
    --mem init
		  0 => x"6041", -- LI 65d
        1 => x"0200", -- STA		  
		  
		  2 => x"605d", -- LI 93d
        3 => x"0201", -- STA 			  
		  
		  4 => x"6004", -- LI 4d
		  5 => x"0202", -- STA		  
		  
		  6 => x"6007", -- LI 7d
		  7 => x"0203", -- STA		  
		  
		  8 => x"6002", -- LI 2d
		  9 => x"0204", -- STA		  
		  
		  10 => x"6007", -- LI 7d
		  11 => x"0205", -- STA		  
		  
		  12 => x"6003", -- LI 3d
		  13 => x"0206", -- STA		  
		  
		  14 => x"6064", -- LI 100d
		  15 => x"0207", -- STA		  
	--------------------------------
	-- temp 1 = 0 * 4	  
		  16 => x"0104",  -- LDA 4
		  17 => x"7000", -- SWP
		  18 => x"0100", -- LDA 0
		  19 => x"2000", -- MUL
		  20 => x"0210", -- TEMP 1 L
		  21 => x"7000", -- 
		  22 => x"0211", -- TEMP 1 H
	-- temp 2 = 1 * 6		  
		  23 => x"0106",  -- LDA 6
		  24 => x"7000", -- SWP
		  25 => x"0101", -- LDA 2
		  26 => x"2000", -- MUL
		  27 => x"0212", -- TEMP 2 L
		  28 => x"7000", -- 
		  29 => x"0213", -- TEMP 2 H
	-- result00 = temp 1 + temp 2
	-- LSB
		  30 => x"0110",  -- LDA 16
		  31 => x"7000", -- SWP
		  32 => x"0112", -- LDA 18
		  33 => x"1000", -- ADD
		  34 => x"0208", -- STA 08		  
	-- MSB
		  35 => x"0111",  -- LDA 17
		  36 => x"7000", -- SWP
		  37 => x"0113", -- LDA 19
		  38 => x"1000", -- ADD
		  39 => x"0209", -- STA 09
	--------------------------------	  
	-- temp 1 = 0 * 5	  
		  40 => x"0105",  -- LDA 5
		  41 => x"7000", -- SWP
		  42 => x"0100", -- LDA 0
		  43 => x"2000", -- MUL
		  44 => x"0210", -- TEMP 1 L
		  45 => x"7000", -- 
		  46 => x"0211", -- TEMP 1 H
	-- temp 2 = 1 * 7		  
		  47 => x"0107",  -- LDA 7
		  48 => x"7000", -- SWP
		  49 => x"0101", -- LDA 1
		  50 => x"2000", -- MUL
		  51 => x"0212", -- TEMP 2 L
		  52 => x"7000", -- 
		  53 => x"0213", -- TEMP 2 H
	-- result01 = temp 1 + temp 2
	-- LSB
		  54 => x"0110",  -- LDA 16
		  55 => x"7000", -- SWP
		  56 => x"0112", -- LDA 18
		  57 => x"1000", -- ADD
		  58 => x"020a", -- STA 10d
	-- MSB
		  59 => x"0111",  -- LDA 17
		  60 => x"7000", -- SWP
		  61 => x"0113", -- LDA 19
		  62 => x"1000", -- ADD
		  63 => x"020b", -- STA 11d
	--------------------------------	  
	-- temp 1 = 2 * 4	  
		  64 => x"0104",  -- LDA 4
		  65 => x"7000", -- SWP
		  66 => x"0102", -- LDA 2
		  67 => x"2000", -- MUL
		  68 => x"0210", -- TEMP 1 L
		  69 => x"7000", -- 
		  70 => x"0211", -- TEMP 1 H
	-- temp 2 = 3 * 6	  
		  71 => x"0106",  -- LDA 6
		  72 => x"7000", -- SWP
		  73 => x"0103", -- LDA 3
		  74 => x"2000", -- MUL
		  75 => x"0212", -- TEMP 2 L
		  76 => x"7000", -- 
		  77 => x"0213", -- TEMP 2 H
	-- result02 = temp 1 + temp 2
	-- LSB
		  78 => x"0110",  -- LDA 16
		  79 => x"7000", -- SWP
		  80 => x"0112", -- LDA 18
		  81 => x"1000", -- ADD
		  82 => x"020c", -- STA 12d
	-- MSB
		  83 => x"0111",  -- LDA 17
		  84 => x"7000", -- SWP
		  85 => x"0113", -- LDA 19
		  86 => x"1000", -- ADD
		  87 => x"020d", -- STA 13d
	--------------------------------	
	-- temp 1 = 2 * 5	  
		  88 => x"0105",  -- LDA 5
		  89 => x"7000", -- SWP
		  90 => x"0102", -- LDA 2
		  91 => x"2000", -- MUL
		  92 => x"0210", -- TEMP 1 L
		  93 => x"7000", -- 
		  94 => x"0211", -- TEMP 1 H
	-- temp 2 = 3 * 7		  
		  95 => x"0107",  -- LDA 7
		  96 => x"7000", -- SWP
		  97 => x"0103", -- LDA 3
		  98 => x"2000", -- MUL
		  99 => x"0212", -- TEMP 2 L
		  100 => x"7000", -- 
		  101 => x"0213", -- TEMP 2 H
	-- result02 = temp 1 + temp 2
	-- LSB
		  102 => x"0110",  -- LDA 16
		  103 => x"7000", -- SWP
		  104 => x"0112", -- LDA 18
		  105 => x"1000", -- ADD
		  106 => x"020e", -- STA 14d
	-- MSB
		  107 => x"0111",  -- LDA 17
		  108 => x"7000", -- SWP
		  109 => x"0113", -- LDA 19
		  110 => x"1000", -- ADD
		  111 => x"020f", -- STA 15d	 		
	----------------------------------
	-- IO loop	  
		  112 => x"01FF", -- LD A <- mem[FF]  FF maped to io_in
        113 => x"02FE", -- STA mem[254] <- 0 
		  114 => x"0570", -- JMP 112d			  
		  OTHERS => x"ffff"	
	);  
	
begin
	
--	process(clk)
--	begin
--		if enable '1' then
--			if(rising_edge(clk)) then
--				q <= rom(conv_integer(addr));
--			end if;
--		end if;
--	end process;
	
	--begin	
	-- read process
	process (clk, rd, enable, addr)
	begin
		
		if enable = '1' and rd = '1' then
			if rising_edge (clk) then
				q <= rom(conv_integer(addr));			
			end if;
		end if;		
	end process;
		
end rtl;
