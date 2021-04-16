%%usarei k como 5 por escolha, visto que o sistema é estavel entre
%%0<k<2623,28
k=1;
a=6.63*k;
num=[0 0 0 6.63*k];%%considerando que F é a FTMF, encontrei G calculando, mostrar caderno
den1=[1 101.71 171 0];
den=[1 101.71 171 6.63*k];
G=tf(num,den1);%%FTMA
F=tf(num,den);
% h=1;
% step(F)
% subplot(1,2,1)
% rlocus(G)
% pzplot(G)%%nao tem zeros, polos em -100, -1.71 e 0
%%vou tentar usar um controlar PI pra melhorar a a velocidade da resposta
%%quis usar mp=0.1 e ts=10s, pra ser mais rapido que sem o controlador
%%com isso obtive Gc(s)=94.48*(s+0.7993) mostrar caderno
numfc=94.48*a*[0 0 0 0 1 0.7993]; %mantendo o k=5, esse é o numerador da ftmacompensada
demfc=[1 101.71 171 0 0];%%denominador da ftmacompensada
FTMAcomp=tf(numfc,demfc)%%duvida:devo fazer q a função de saida ter realimentação negativa? Sendo entao X(s)=ftmacomp/(1+ftmacomp)??
% subplot(1,2,2)
% rlocus(FTMAcomp)
numftr=6.63*94.98*[0 0 0 k 0.7993];
demftr=[1 101.71 171 6.63*k*94.98 0.7993*6.63*k*94.98];%se a resposta pra duvida for sim, essa é a nova ft do sistema
FTMAcomprea=tf(numftr,demftr);
step(FTMAcomprea) %deu ruim, passou a ser um sistema oscilatorio, pq? Alem disso sobresinal ficou enorme




