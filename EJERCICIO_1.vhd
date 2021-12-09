
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_1164.ALL;


entity EJERCICIO_1 is
	Port(CS,WE,CLK : in  STD_LOGIC;
			ADRS		: in  STD_LOGIC_VECTOR  ( 3 downto 0);
			DATA_IN 	: in  STD_LOGIC_VECTOR  ( 7 downto 0);
			DATA_OUT : out STD_LOGIC_VECTOR  ( 7 downto 0));
end EJERCICIO_1;

architecture Behavioral of EJERCICIO_1 is
	--RAM
	type RAM_TABLE is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
	signal RAM_MEMORY : RAM_TABLE;
	--RELOJ
	signal CONT : STD_LOGIC_VECTOR (25 downto 0);
	signal CLK1HZ : STD_LOGIC;
begin
	
	Clock_Contador : process (CLK)
	begin
		if(rising_edge(CLK)) then 
			CONT <= CONT + '1';
		end if;
	end process;
	
	CLK1HZ <= CONT(25);
	
	Memoria_RAM : process(CLK1HZ,WE)
	begiN
		if(RISING_EDGE(CLK1HZ)) then
			if(CS = '0') then
				if (WE = '0') then
					--READ
					DATA_OUT <= RAM_MEMORY(conv_integer(ADRS));
				else 
					--WRITE
					RAM_MEMORY(CONV_INTEGER(ADRS)) <= DATA_IN;
				end if;
			end if;
		end if;
	end process;

end Behavioral;