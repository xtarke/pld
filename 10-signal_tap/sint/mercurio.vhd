library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mercurio is
	port (
		CLOCK_50MHz 	: in	std_logic;
		SW			   	: in 	std_logic_vector(3 downto 0);    --operandos(15 downto 8 => operando2, 7 downto 0 => operando1)
		KEY		   	: in 	std_logic_vector(11  downto 0);  --comando(3=>'start_send',0=>'rst');
		-- Interface UART
		UART_TXD			: out std_logic;
		-- LED RGB
		LED_R          : out std_logic;
		LED_G          : out std_logic;
		LED_B          : out std_logic;
		-- LCD
		LCD_D		      : inout	std_logic_vector(7  downto 0); 	-- LCD data is a bidirectional bus...
		LCD_RS 	   	: out   std_logic;                		-- LCD register select
		LCD_RW  	   	: out   std_logic;                		-- LCD Read / nWrite
		LCD_EN  		   : out   std_logic;                		-- LCD Enable
		LCD_BACKLIGHT	: out   std_logic;
		
		GPIO1_D			: inout std_logic_vector(35  downto 0);
		
		DISP0_D			: out std_logic_vector(7 downto 0);
		DISP1_D			: out std_logic_vector(7 downto 0);
		
		-- Matriz de LEDs
		LEDM_C		:		out std_logic_vector(4 downto 0);
		LEDM_R		:		out std_logic_vector(7 downto 0)
	);
end mercurio;


architecture behavior of mercurio is
	signal value : unsigned(7 downto 0);
	
	signal hex : std_logic_vector(7 downto 0);
	signal disp_0 : std_logic_vector(7 downto 0);
	signal disp_1 : std_logic_vector(7 downto 0);
	
begin

	counter_01: entity work.counter
		generic map(
			BITS => 7
		)
		port map(
			clk   => SW(0),
			rst   => SW(1),
			value => value
		);

	LEDM_C <= (others => '1');

	hex <= std_logic_vector(value);
		
	disp_00: entity work.display_dec
		port map(
			hex  => hex(3 downto 0),
			disp => disp_0
		);
		
	disp_01: entity work.display_dec
		port map(
			hex  => hex(7 downto 4),
			disp => disp_1
		);
		
	DISP0_D <= not disp_0;
	DISP1_D <= not disp_1;


end architecture;

