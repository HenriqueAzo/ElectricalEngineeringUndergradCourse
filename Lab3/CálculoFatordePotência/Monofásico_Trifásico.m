clear all;
close all;
clc;
#{
Entradas:
- Tensão monofásica
- Carga (número complexo)

Saídas (na ordem):
- Fasor de tensao atual (V)
- Fasor de corrente atual (I) ou (I1, I2, I3)
- Potências atuais:
    Ativa (P)
    Reativa (Q)
    Aparente  (S)
- Atual Fator de Potência (FP)

Depois da correcao

- Tensao nova (V) ou (V1, V2, V3)
- Corrente Nova (I) ou (In1, In2, In3)
- Potências novas:
    Ativa     (Pn)
    Reativa   (Qn)
    Aparente  (Sn)
- Capacitor apropriado para fazer a correcao (1 para monofasico, 3 para trifasico)
#}

  #pedir a informação: monofásico ou trifásico
escolha=input("\n\ndigite:\n(1) para analisar um sistema monofasico\n(2) para analisar um sistema trifasico\n\n");

  #checar se a escolha foi valida
nerros=0;
while(!xor(escolha==1,escolha==2))
  fprintf("\nEscolha invalida. Digite apenas as alternativas presentes.\n");
  nerros=nerros+1;
  escolha=input("\ndigite:\n(1) para analisar um sistema monofasico\n(2) para analisar um sistema trifasico\n\n");
  if(nerros>3)
    fprintf("\nQuantidade maxima de tentativas atingida. Saindo do programa...\n")
    return;
  endif
endwhile
#

w=2*pi*60

#correcao de sistema monofasico
if(escolha==1)
  V=input("insira o valor da tensão monofásica: ");
  Zr=input("\n insira o primeiro valor da carga (parte real, unidade ohm): ");
  Zi=input("\n insira o primeiro valor da carga (parte imaginaria, unidade ohm): ");
  Z=complex(Zr,Zi)

  if(real(Z)==0)
    fprintf("\n\nO circuito consiste apenas de cargas reativas. \nO fator de potencia permanece zero, independente de correcoes com outras cargas reativas.\n\n")
    return;
  endif
  #
  if(imag(Z)==0)
  fprintf("\n\nO circuito, sendo puramente resistivo, possui o FP igual a 1. Nenhuma correcao se faz necessaria.")
  return;
  endif
  #
  #
  #definindo corrente
  fprintf("\nCorrente inicial: ");
  I=V/Z

  #definir potência inicial
  fprintf("\nPotência complexa inicial: ");
  S=(V*conj(I))/2
  P=real(S)
  Q=imag(S)

    #Plotando o triangulo de potencia atual
  subplot(2,2,1);
  hold on;
  grid on;
    #potencia atual
  line([0 P], [0 0], "linestyle", "-", "color", "b")
  line([P P], [0 Q], "linestyle", "-", "color", "r")
  line([0 P], [0 Q], "linestyle", "-", "color", "g")

  hold off;

    #definir FP atual
  fprintf("\nFator de potencia atual: ");
  FP=cos(atan(imag(S)/real(S)))


    #fasores de V e I atuais
  subplot(2,2,2);
  hold on;
  grid on;
  #limitando grafico dos fasores
  modi=mod(real(I),imag(I));
  if(modi<V)
    xlim([-V-(V*0.08),V+(V*0.08)]);
    ylim([-V-(V*0.08),V+(V*0.08)]);
  endif
  if(modi>V) #AINDA FALTA CORRIGIR ISSO
    xlim([-modi-(modi*0.08),modi+(modi*0.08)]);
    ylim([-modi-(modi*0.08),modi+(modi*0.08)]);
  endif
    #fasores
  compass(V,0);
  compass(real(I),imag(I));

  hold off;

  FPDesejado=input("\nPara que que Fator de potencia se deseja corrigir o circuito atual?\n")
  #checando se 0<=FP<=1
  while(FPDesejado>1 || FPDesejado<0)
    FPDesejado=input("\n Valor invalido. insira um valor tal que 0<=FP<=1.")
  endwhile
  #

    #fórmula para capacitor do FP
  fprintf("\n\nCalculando C: ");
  C=(real(S)/((V.^2)*w))*(tan(acos(FP))-tan(acos(FPDesejado)))

    #calculando nova potencia apos correcao
  Sc=complex(0,-1)*w*C*pow2(V)
  S=S+Sc
  P=real(S)
  Q=imag(S)

    #Plotando o triangulo de potencia apos correcao
  subplot(2,2,3);
  hold on;
  grid on;
    #potencia atual
  line([0 P], [0 0], "linestyle", "-", "color", "b")
  line([P P], [0 abs(Q)], "linestyle", "-", "color", "r")
  line([0 P], [0 abs(Q)], "linestyle", "-", "color", "g")

  hold off;

    #definir FP atual
  fprintf("\nFator de potencia atual: ");
  FP=cos(atan(imag(S)/real(S)))

    #definindo nova corrente
  Zc=1/(complex(0,1)*w*C)
  Z=1/((1/Z)+(1/Zc))
  I=V/Z

    #fasores de V e I atuais
  subplot(2,2,4);
  hold on;
  grid on;
    #limitando grafico dos fasores
  modi=mod(real(I),imag(I));
  if(modi<V)
    xlim([-V-(V*0.08),V+(V*0.08)]);
    ylim([-V-(V*0.08),V+(V*0.08)]);
  endif
  if(modi>V) #AINDA FALTA CORRIGIR ISSO
    xlim([-modi-(modi*0.08),modi+(modi*0.08)]);
    ylim([-modi-(modi*0.08),modi+(modi*0.08)]);
  endif
    #fasores
  compass(V,0);
  compass(real(I),imag(I));

endif
#


#correcao de sistema trifasico
if(escolha==2)
  V=input("insira o valor da tensão monofásica: ");
  Zr=input("\n insira o primeiro valor da carga (parte real, unidade ohm): ");
  Zi=input("\n insira o primeiro valor da carga (parte imaginaria, unidade ohm): ");
  Z=complex(Zr,Zi)

  if(real(Z)==0)
    fprintf("\n\nO circuito consiste apenas de cargas reativas. \nO fator de potencia permanece zero, independente de correcoes com outras cargas reativas.\n\n")
    return;
  endif
  #
  I=V/Z
endif
#
