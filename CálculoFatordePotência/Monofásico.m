#Cálculo de componentes monofásicos

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
- Capacitor necessário para corrigir o FP para 0.92
- Nova corrente e novas potências
- Capacitor necessário para corrigir o FP para 0.96
- Nova corrente e novas potências
- Capacitor necessário para corrigir o FP para 1.00
- Nova corrente e novas potências
#}

V=input("insira o valor da tensão monofásica (forma retangular): ")
Z=input("insita o valor da carga (forma retangular): ")

w=2*pi*60;

#definindo corrente, theta inicial e FP inicial
I=V/Z
conjI=conj(I)
theta=atan(imag(I)/real(I))
FP=cos(theta)

#definir potência inicial
S=(V*conj(I))/2

#corrigindo FP para 0.92
