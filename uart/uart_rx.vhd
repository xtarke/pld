
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
	port(
		clk : in std_logic;
		rst : in std_logic;
		
		en : in std_logic;
		data_in : in std_logic;
		
		done : out std_logic;
		data_out : out std_logic_vector(7 downto 0)
	);
end entity uart_rx;


architecture RTL of uart_rx is
	type state_type is (IDLE, START_BIT, DATA, STOP_BIT, FRAME_ERROR);
	signal state_fsm : state_type;
	
	signal ser_data: std_logic_vector(7 downto 0);
	signal bits : integer range 0 to 10;
	
	signal reg_en : std_logic;
	signal shift_reg_en : std_logic;
	
	
	signal s : std_logic;
begin
	
	fsm: process (clk, rst)
		variable cnt : integer range 0 to 10;
	begin
		if rst = '1' then
			state_fsm <= IDLE;
			cnt := 7;
		else			
			if rising_edge(clk) then			
				case state_fsm is 
					when IDLE =>
						if en = '1' and data_in = '0' then
							state_fsm <= START_BIT;
						end if;					
					when START_BIT =>
						--if data_in = '0' then
							state_fsm <= DATA;
							cnt := cnt - 1;
						--end if;
					when DATA =>		
						if cnt /= 0  then
							state_fsm <= DATA;
							cnt := cnt - 1;
						else
							state_fsm <= STOP_BIT;
						end if;						
					when STOP_BIT =>
						if data_in = '1' then
							state_fsm <= IDLE;
						else
							state_fsm <= FRAME_ERROR;
						end if;
					when FRAME_ERROR =>
						state_fsm <= IDLE;	
				end case;
			
				bits <= cnt;			
			end if;			
		end if;		
	end process;
	
	moore: process (state_fsm)
	begin
		done <= '0';
		reg_en <= '0';
		shift_reg_en <= '0';
				
		case state_fsm is 
			when IDLE =>
					
			when START_BIT =>
				shift_reg_en <= '1';
			when DATA =>
				shift_reg_en <= '1';
				--ser_data(bits) <= data_in;
			when STOP_BIT =>
				done <= '1';
				reg_en <= '1';
			when FRAME_ERROR => 				
		end case;		
	end process;
	
	s <= '1';
	
	shift_reg: process (clk, rst, shift_reg_en)
	begin
		if rst = '1' then
			ser_data <= (others => '0');
		else
			if rising_edge(clk) and shift_reg_en = '1' then
				ser_data(bits) <= data_in;
			end if;
		end if;
	end process;	
	
	
	
	data_register: process(clk, rst, reg_en)
	begin
		if rst = '1' then
			data_out <= (others => '0');
		else
			if rising_edge(clk) and reg_en = '1' then
				data_out <= ser_data;
			end if;
		end if;
	end process;	
	
end;