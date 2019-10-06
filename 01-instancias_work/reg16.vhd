LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY reg16 IS
PORT (
          clk: in std_logic;
          sclr_n: in std_logic;
          clk_ena: in std_logic;
          datain: in std_logic_vector(15 downto 0);
          reg_out: out std_logic_vector(15 downto 0)
         );
END ENTITY reg16;

ARCHITECTURE reg16_beh Of reg16 IS
  
BEGIN

	 process(clk)
    begin
       if (CLK'event and CLK = '1') then
				if clk_ena = '1' then
						if sclr_n = '0' then
							reg_out <= (others => '0');
						else
							reg_out <= datain;
						end if;
				end if;
       end if;
    end process;
	
END ARCHITECTURE reg16_beh;
