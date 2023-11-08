library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is end;

architecture testbench of tb is

	component main
    	port(
			A: in std_logic_vector(3 downto 0) ;
			B: in std_logic_vector(3 downto 0) ;
			Start: in std_logic ;
			Reset: in std_logic;
			Output: out std_logic_vector(7 downto 0)
		);
    end component main;
    
    
    --entradas e saídas tratadas por sinais, na mesma ordem que no componente
    signal sA:   		std_logic_vector(3 downto 0);
    signal sB:   		std_logic_vector(3 downto 0);
    signal Stt:  		std_logic;
    signal Rst:  		std_logic;
    signal Outp: 		std_logic_vector(7 downto 0);

    
    begin
    

    
    --assinalando as entradas e saídas aos sinais tratados
    dut: main port map( 	 A=> sA,
							 B=> sB,
							 Start=> Stt,
							 Reset=> Rst,
                             Output=> Outp
							);
    
    
    inc: process is
    begin
    Rst <= '1';
    wait for 10 ns;
    Rst <= '0';
    wait for 5 ns;
    
    sA <= "0001";
    sB <= "0100";
    Stt<= '1';
    Rst<= '0';
    
    wait for 30 ns;
    
    Stt<= '0';
   
    wait for 400 ns;
    
    report "resultado: " 	& to_string(Outp);


    wait;
    
end process;
end testbench;

