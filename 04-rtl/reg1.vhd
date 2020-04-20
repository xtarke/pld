library ieee;
use ieee.std_logic_1164.all;

entity reg1 is
	port (
		clk : in std_logic;
    	d : in std_logic;
        q : out std_logic
  );
end entity reg1;

architecture logic of reg1 is
  signal a, b : std_logic;
begin
  process (clk)
  begin
    -- Colocar reset aqui.
    -- Exemplo criado para demonstrar latência
    -- entre d e q    
    if rising_edge (clk) then
      a <= d;
      b <= a;
      q <= b;
    end if;
  end process;
end architecture logic;