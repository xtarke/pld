library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
	generic (ADDR_BUS : integer := 16;
			DATA_IN_BUS : integer := 16;
			COEF_BIT : integer := 16;
			N_SAMPLES : integer := 40
	);
end entity testbench;

architecture RTL of testbench is
	
	component uart_tx
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			en       : in  std_logic;
			data_in  : in  std_logic_vector(7 downto 0);
			done     : out std_logic;
			data_out : out std_logic
		);
	end component uart_tx;
	
	component uart_rx
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			en       : in  std_logic;
			data_in  : in  std_logic;
			done     : out std_logic;
			data_out : out std_logic_vector(7 downto 0)
		);
	end component uart_rx;
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal en  : std_logic;
	signal done : std_logic;
	
	signal data : std_logic_vector(7 downto 0);
	signal serialData : std_logic;
	
	
	
begin

--	u0 : uart_tx
--		port map(
--			clk      => clk,
--			rst      => rst,
--			en       => en,
--			data_in  => data,
--			done     => done,
--			data_out => serialData
--		);

	u1: uart_rx
		port map(
			clk      => clk,
			rst      => rst,
			en       => en,
			data_in  => serialData,
			done     => done,
			data_out => data
		);

	-- data <= x"43", x"50" after 13 us;

	clk_p: process 
	begin
		clk <= '0';
		wait for 1 us;
		clk <= '1';
		wait for 1 us;
	end process;
	
	rst_p: process
	begin
		rst <= '1';
		wait for 5 us;
		rst <= '0';		
		wait;	
	end process;
	
	
	
	serial: process
		 constant ser_data: std_logic_vector(9 downto 0) := "1011010010";
	begin
		serialData <= '1';
		wait for 9 us;
		for i in ser_data'range loop
		    serialData <= ser_data(i);
		    wait for 2 us;
		end loop;
		serialData <= '1';
		wait;
	end process;
			
    en <= '0', '1' AFTER 5 uS; --, '0' after 20 us, '1' after 35 us;

end architecture RTL;
