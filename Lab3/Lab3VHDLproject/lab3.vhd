---lab3 project summary
-- inputs:
--		clk 50mhz in
--		mux para seletor de duty cycle
--		botao de reset para voltar a contagem para zero
--
--	interno:
--		divisor de frequência (50mhz papra 1hz)
--		funçao para contagem e output 7 segmentos
--
--	outputs:
--		dois 7seg (dezena, unidade)
--		1 LED que pisca a cada 5 pulsos de 1hz
--		onda quadrada de 1hz com duty cycle selecionado pelo mux inicial
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab3 is
Port (
CLK : 								IN STD_LOGIC;		--entrada do clock interno de 50MHz
M0,M1,M2 : 							IN STD_LOGIC;		--entrada do mux
RST : 								IN STD_LOGIC;		--botao para reset
Ax,Bx,Cx,Dx,Ex,Fx,Gx : 			out STD_LOGIC;		--saida para display 7seg
A2x,B2x,C2x,D2x,E2x,F2x,G2x : out STD_LOGIC;		--saida para display 7seg							
CLK1: 								OUT STD_LOGIC;		--saida do clock de 1Hz
CYCLE5 : 							OUT STD_LOGIC);	--sinal para 5 ciclos
end lab3;
 
architecture Behavioral of lab3 is
	signal B0,B1,B2,B3 : STD_LOGIC;		--BCD da unidade
	signal B21,B22,B23,B24 : STD_LOGIC;	--BCD da dezena	
	signal b : STD_LOGIC := '0'; 			--novo clk de 1hz
begin
	process(clk)	
	variable a 		 :	integer := 0; 	--contador para o divisor de freq.
	variable number : integer := 0; 	--contador de ciclos;
	variable decade : integer := 0; 	--contador de dezenas;
	begin
	
		--inicio do process(clk)
		if rising_edge(CLK) then				
			a := a+1;
			if a=25000000 and b='0' then   	
				b<='1'; a:=0; CLK1 <=b;
				if number<9 then 
					number:=number+1;
				else
					number:=0;
					if decade<9 then
						decade:=decade+1;
					else
						decade :=0;
					end if;
				end if;
			elsif a=25000000 and b='1' then 	
				b<='0'; a:=0; CLK1<=b;
			end if;
		end if;
		-- fim da divisao de frequencia. agora, b vira o clock de 1hz que usaremos.

		case number is
		when 0 =>
			B0 <='0';
			B1 <='0';
			B2 <='0';
			B3 <='0';
		when 1 =>
			B0 <='1';
			B1 <='0';
			B2 <='0';
			B3 <='0';
		when 2 =>
			B0 <='0';
			B1 <='1';
			B2 <='0';
			B3 <='0';
		when 3 =>
			B0 <='1';
			B1 <='1';
			B2 <='0';
			B3 <='0';
		when 4 =>
			B0 <='0';
			B1 <='0';
			B2 <='1';
			B3 <='0';
		when 5 =>
			B0 <='1';
			B1 <='0';
			B2 <='1';
			B3 <='0';
		when 6 =>
			B0 <='0';
			B1 <='1';
			B2 <='1';
			B3 <='0';
		when 7 =>
			B0 <='1';
			B1 <='1';
			B2 <='1';
			B3 <='0';
		when 8 =>
			B0 <='0';
			B1 <='0';
			B2 <='0';
			B3 <='1';
		when 9 =>
			B0 <='1';
			B1 <='0';
			B2 <='0';
			B3 <='1';
		when others =>
			B0 <='1';
			B1 <='1';
			B2 <='1';
			B3 <='1';
		end case;
		
		case decade is
		when 0 =>
			B0 <='0';
			B1 <='0';
			B2 <='0';
			B3 <='0';
		when 1 =>
			B0 <='1';
			B1 <='0';
			B2 <='0';
			B3 <='0';
		when 2 =>
			B0 <='0';
			B1 <='1';
			B2 <='0';
			B3 <='0';
		when 3 =>
			B0 <='1';
			B1 <='1';
			B2 <='0';
			B3 <='0';
		when 4 =>
			B0 <='0';
			B1 <='0';
			B2 <='1';
			B3 <='0';
		when 5 =>
			B0 <='1';
			B1 <='0';
			B2 <='1';
			B3 <='0';
		when 6 =>
			B0 <='0';
			B1 <='1';
			B2 <='1';
			B3 <='0';
		when 7 =>
			B0 <='1';
			B1 <='1';
			B2 <='1';
			B3 <='0';
		when 8 =>
			B0 <='0';
			B1 <='0';
			B2 <='0';
			B3 <='1';
		when 9 =>
			B0 <='1';
			B1 <='0';
			B2 <='0';
			B3 <='1';
		when others =>
			B0 <='1';
			B1 <='1';
			B2 <='1';
			B3 <='1';
		end case;
	end process;
	
	
	Ax <= B0 OR B2 OR (B1 AND B3) OR (NOT B1 AND NOT B3);
	Bx <= (NOT B1) OR (NOT B2 AND NOT B3) OR (B2 AND B3);
	Cx <= B1 OR NOT B2 OR B3;
	Dx <= (NOT B1 AND NOT B3) OR (B2 AND NOT B3) OR (B1 AND NOT B2 AND B3) OR (NOT B1 AND B2) OR B0;
	Ex <= (NOT B1 AND NOT B3) OR (B2 AND NOT B3);
	Fx <= B0 OR (NOT B2 AND NOT B3) OR (B1 AND NOT B2) OR (B1 AND NOT B3);
	Gx <= B0 OR (B1 AND NOT B2) OR ( NOT B1 AND B2) OR (B2 AND NOT B3);
 
end Behavioral;
