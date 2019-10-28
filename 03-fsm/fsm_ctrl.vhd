library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
	port(
		clk : in std_logic;
		rst : in std_logic;
		start : in std_logic;
		set_point: in unsigned(15 downto 0);
		temperature: in unsigned(15 downto 0);
		motor : out std_logic
	);
end entity fsm;

architecture RTL of fsm is
	type state_type is (IDLE, ST_ON, MOTOR_ON);

	signal state : state_type;
begin

	state_transation: process(clk, rst) is
	begin
		if rst = '1' then
			state <= IDLE;
		elsif rising_edge(clk) then
			case state is
				when IDLE =>
					if start = '1' then					
						state <= ST_ON;
					end if;
				when ST_ON =>
					if (start = '0') then 
						state <= IDLE;
					elsif (temperature > set_point) then
						state <= MOTOR_ON;
					end if;
				when MOTOR_ON =>
					if (start = '0') then					
						state <= IDLE;
					elsif (temperature <= set_point) then
						state <= ST_ON;
					end if;
			end case;
		end if;
	end process;
	
	
--	moore: process(state)
--	begin
--		motor <= '0';					
--		case state is 
--			when IDLE =>				
--			when ST_ON =>
--			when MOTOR_ON =>
--				motor <= '1';
--		end case;
--	end process;
		
	mealy_moore: process(state, start) -- Mealy needs start
	begin
		motor <= '0';
		
		case state is 
			when IDLE =>			
		
			when ST_ON =>
		
			when MOTOR_ON =>
				motor <= '1';
				
				if (start = '0') then  -- Meely reads input
					motor <= '0';
				end if;
				
		end case;
		
	end process;
	
	
	

end architecture RTL;
