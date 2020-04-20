library ieee;
use ieee.std_logic_1164.all;

entity latch1 is
  port (
    data : in std_logic;
    gate : in std_logic;
    q : out std_logic
  );
end entity latch1;

architecture logic of latch1 is
begin
  label_1: process (data, gate)
  begin
    if gate = '1' then
      q <= data;
    end if;
  end process label_1;
end architecture logic;