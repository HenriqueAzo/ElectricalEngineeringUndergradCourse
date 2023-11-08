library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
--alteracao

entity main is port(
A: in std_logic_vector(3 downto 0) ;
B: in std_logic_vector(3 downto 0) ;
Start: in std_logic ;
Reset: in std_logic;
Output: out std_logic_vector(7 downto 0)
);
end main;



architecture funcionamento of main is

--palavra sobre a qual se farao operacoe
--sinal entra
--é armazenado
--se julga o que tem que ser feito
--se faz, conta-se uma iteraçao
--repete o processo
--apos 4 iteracoes o output eh dado
begin
process(A, B, Start, Reset)


--variavel para contar iteracoes

variable boothA: std_logic_vector(9 downto 0);
variable boothS: std_logic_vector(9 downto 0);
variable boothP: std_logic_vector(9 downto 0);

begin


    
boothA := A(3) & A & "00000"; 
boothS := (not(A(3) & A) + 1) & "00000"; 
boothP := "00000" & B & '0';

for i in 0 to 3 loop

    if(boothP(1 downto 0) = "01") then
        boothP := boothP + boothA;
    elsif (boothP(1 downto 0) = "10") then
        boothP := boothP + boothS;        
    end if;

    boothP := boothP(9) & boothP(9 downto 1);

end loop;




Output <= boothP(8 downto 1);


end process;

end funcionamento;
