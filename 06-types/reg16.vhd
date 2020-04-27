library ieee;
use ieee.std_logic_1164.all;

entity reg16 is
	port (
		clk: in std_logic;
		sclr_n: in std_logic;
		clk_ena: in std_logic;
		datain: in std_logic_vector(15 downto 0);
		reg_out: out std_logic_vector(15 downto 0)
	);
end entity reg16;

architecture reg16_beh of reg16 is

begin
	process(clk, sclr_n)
	begin
		if sclr_n = '0' then 
			reg_out <= (others => '0');
		elsif (clk'event and clk = '1') then
			if clk_ena = '1' then
					reg_out <= datain;
			end if;
		end if;
	end process;

end architecture reg16_beh;
