library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EJERCICIO_2 is
	Port( CS,CLK			: in  STD_LOGIC;
			SEGMENTOS	: out STD_LOGIC_VECTOR (7 downto 0);
			DISPLAYS 	: out STD_LOGIC_VECTOR (7 downto 0));

end EJERCICIO_2;

		architecture Behavioral of EJERCICIO_2 is
	--señales para RELOJ 1S para carrusel
	signal CONT : STD_LOGIC_VECTOR (25 downto 0);
	signal CLK1HZ : STD_LOGIC;
	--contador para multiplexar displays 
	signal CONTADOR : INTEGER range 0 to 100000;
	--Señales para multiplexar displays.
	signal SELECTOR : STD_LOGIC_VECTOR (2 downto 0) :="000";
	signal MOSTRADOR : STD_LOGIC_VECTOR (7 downto 0) :="00000000";
	signal Num1,Num2,Num3,Num4,Num5,Num6,Num7,Num8 : STD_LOGIC_VECTOR (7 downto 0);
	--ROM
	type ROM_TABLE is array (1 to 16) of STD_LOGIC_VECTOR(7 downto 0);
	signal ROM_MEMORY : ROM_TABLE := (
	x"87",--J
	x"03",--O
	x"49",--S
	x"61",--E
	
	x"EF",--_
	
	x"11",--A
	x"13",--N
	x"13",--N
	x"61",--E
	
	x"EF",--_
	
	x"0C",--M
	x"11",--A
	x"71",--F
	x"63",--C
	
	x"Fe",--.
	x"FF");--
	
begin

	CONTADOR_PARA SELECIONAR DISPLAYS: PROCESS(CLK)
	BEGIN
		if rising_edge(CLK) then
			if CONTADOR < 100000 then
				CONTADOR <= CONTADOR + 1;
			else
				SELECTOR <= SELECTOR + 1;
				CONTADOR <= 0;   
			end if;
		end if;
	END PROCESS;
	
	Clock_Contador : process (CLK)
	begin
		if(rising_edge(CLK)) then 
			CONT <= CONT + '1';
		end if;
	end process;
	
	CLK1HZ <= CONT(25);
	
	Mostrar_Displays: PROCESS(SELECTOR,MOSTRADOR,Num1,Num2,Num3,Num4,Num5,Num6,Num7,Num8)
	BEGIN 
			--La funcion del selector es seleccionar y prender un display de los 8 que tenemos,
		case SELECTOR is 
			when "000" =>
				MOSTRADOR <= "11111110";
			when "001" =>
				MOSTRADOR <= "11111101";
			when "010" =>
				MOSTRADOR <= "11111011";
			when "011" =>
				MOSTRADOR <= "11110111";
			when "100" =>
				MOSTRADOR <= "11101111";
			when "101" =>
				MOSTRADOR <= "11011111";
			when "110" =>
				MOSTRADOR <= "10111111";
			when "111" =>
				MOSTRADOR <= "01111111";
			when others =>
				MOSTRADOR <= "11111111";
		end case;
		
		-- Una vez seleccionado el display le asignamos un Num# que contiene el dato que queremos mostrar.
		
		case MOSTRADOR is
			when "11111110" =>
				SEGMENTOS <= Num8;
			when "11111101" =>
				SEGMENTOS <= Num7;
			when "11111011" =>
				SEGMENTOS <= Num6;
			when "11110111" =>
				SEGMENTOS <= Num5;
			when "11101111" =>
				SEGMENTOS <= Num4;
			when "11011111" =>
				SEGMENTOS <= Num3;
			when "10111111" =>
				SEGMENTOS <= Num2;
			when "01111111" =>
				SEGMENTOS <= Num1;
			when others =>
				SEGMENTOS <= "11111111";
		end case;
	END PROCESS;
	
	
	process(CLK1HZ,ROM_MEMORY,CS)
	begin
		if(CS = '0') then
			if(RISING_EDGE(CLK1HZ)) then
			--CORRIMIENTO hacia la izquierda
		 ROM_MEMORY <= ROM_MEMORY(16) & ROM_MEMORY( 1 to 15);
			Num1 <= ROM_MEMORY(1); 
			Num2 <= ROM_MEMORY(2); 
			Num3 <= ROM_MEMORY(3); 
			Num4 <= ROM_MEMORY(4); 
			
			Num5 <= ROM_MEMORY(5); 
			Num6 <= ROM_MEMORY(6); 
			Num7 <= ROM_MEMORY(7); 
			Num8 <= ROM_MEMORY(8); 
			end if;
		else 
			Num1 <= x"00";
			Num2 <= x"00";
			Num3 <= x"00";
			Num4 <= x"00";
			Num5 <= x"00";
			Num6 <= x"00";
			Num7 <= x"00";
			Num8 <= x"00";
	end if;
	end process;
		
		DISPLAYS <= MOSTRADOR;
	
end Behavioral;