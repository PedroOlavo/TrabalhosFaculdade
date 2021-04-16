k=1;
a=6.63*k;%%sistema é estavel para 0<k<2623
num=[0 0 0 6.63*k];
den1=[1 101.71 171 0];
den=[1 101.71 171 6.63*k];
G=tf(num,den1);%%FTMA
F=tf(num,den);%%FTMF
% rlocus(G)%%root locus da FTMA
step(F)%%resposta ao degrau