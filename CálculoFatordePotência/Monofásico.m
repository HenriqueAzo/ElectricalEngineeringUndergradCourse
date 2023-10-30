#Cálculo de componentes monofásicos
clear all;
close all;
clc;
#{
Entradas:
- Tensão monofásica
- Carga (número complexo)

Saídas (na ordem):
- Fasor de corrente
- Potências atuais:
    Ativa
    Reativa
    Aparente
- Atual Fator de Potência
- Capacitor necessário para corrigir o FP para 0.92 (theta=23.074)
- Nova corrente e novas potências
- Capacitor necessário para corrigir o FP para 0.96 (theta=16.26)
- Nova corrente e novas potências
- Capacitor necessário para corrigir o FP para 1.00 (theta=0)
- Nova corrente e novas potências
#}

V=input("insira o valor da tensão monofásica: ");
Z=input("\n insira o valor da carga (forma retangular): ");

if(real(Z)==0)
  fprintf("\n\nO circuito consiste apenas de cargas reativas. \nO fator de potencia permanece zero, independente de correcoes com outras cargas reativas.\n\n")
  return;
  endif
#

caso=input("\n\nInsira: \n(1) para realizar os calculos sobre um circuito monofasico;\n(2) para realizar os calculos sobre um circuito trifasico.\n");

if(caso==1)
#definindo corrente, w
fprintf("\nCorrente inicial: ");
I=V/Z
w=2*pi*60;

#definir potência inicial
fprintf("\nPotência complexa inicial: ");
S=(V*conj(I))/2

#definir FP inicial
fprintf("\nFator de potencia atual: ");
FP=cos(atan(imag(S)/real(S)))
FPDesejado=input("\nPara que que Fator de potencia se deseja corrigir o circuito atual?\n")

while(FPDesejado>1 || FPDesejado<0)
  FPDesejado=input("\n Valor invalido. insira um valor tal que 0<=FP<=1.")
endwhile
#
#fórmula para FP=0.92
fprintf("\n\nCalculando C: ");
C=(real(S)/((V.^2)*w))*(tan(acos(FP))-tan(acos(FPDesejado)))
endif
#fim do caso monofasico
