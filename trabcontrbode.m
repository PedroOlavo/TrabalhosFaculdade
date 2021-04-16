k=1;
%a=6.63*k;%%sistema é estavel para 0<k<2623
num=[0 0 0 6.63*k];
den1=[1 101.71 171 0];
den=[1 101.71 171 6.63*k];
G=tf(num,den1);%%FTMA
%Gc=tf(0.38944*[65 1],[1 0]);%%função do controlador, obtida no SISO tool
bode(G)%%bode da ftma
num2=[0 0 0 167.8 2.582];
den2=[1 101.71 171 167.8 2.582];
F=tf(num2,den2) %FTMFcompensada
step(F)