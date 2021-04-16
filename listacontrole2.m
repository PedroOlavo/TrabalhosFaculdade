%%Questão 1
% num=[0 0 1];%%numerador da função
% dem=[1 0.707 1];%%denominador da funçaõ
% g=tf(num,dem);%%fazendo a função transferencia
% f=g/(1+g);
% step(g)

%%Questão 2
% num=[0 0 1];
% dem=[1 5.6 16];
% f=tf(num,dem)
% step(f)

%%Questão 3a
% num=[0 1 -1];
% dem=[1 1 0];
% g=tf(num,dem)
% step(g)

%%Questão 3b
% syms s t
% f=1/(s*(s+1))
% g=ilaplace(f,t)
% ezplot(t,g)

%%Questão 3c
% num=[0 1 1];
% dem=[1 -1 0];
% g=tf(num,dem)
% impulse(g)

%%Questão 4
% num=[0 0 2];
% dem=[0.2 2.1 1];
% g=tf(num,dem)
% step(g)

%%Questão 6
% syms s t
% r=s+1/(s^3);
% g=50/(s*(1+0.1*s));
% f=g*r
% pretty(f)
% F=ilaplace(f);
% ezplot(t,F)

%%questao 14
% num=[0 0 1];
% dem=[1 2 11];
% g=tf(num,dem);
% pole(g)
% rlocus(g)

% num=[0 1 3];
% dem=[1 2 3];
% g=tf(num,dem)
% pole(g)
% rlocus(g)

% num=[0 0 0 0 1];
% dem=[1 1.1 10.3 5 0];
% g=tf(num,dem)
% rlocus(g)

%%questao 18
% num=[0 0 0.8];
% dem=[1 0.2 0.8];
% g=tf(num,dem)
% rlocus(g)

% Questão 24
% num=[0 0 1 1.21];
% dem=[1 4 0 0];
% g=tf(num,dem)
% rlocus(g)

% QUESTAO 1
% num = [0 0 4];
% dem = [5 1 0];
% g=tf(num,dem);
% h=1;
% sis=g/(1+g*h);
% step(0.2*sis)
% rlocus(g)
%%
%%lista prova 2
% num=[0 0 0 1];
% dem=[1 6 8 0];
% g=tf(num,dem);
% bode(g)

%1b
% num=[0 1 5];
% dem=[1 6 8];
% g=tf(num,dem)
% bodemag(g)

%3
num=[0 0 0 1];
dem=[1 11 38 40];
g=tf(num,dem)
bode(g)
margin(g)

%7
% num=[0 0 0 50];
% dem=[1 9 18 50];%ftma do sistema apresentado
% g=tf(num,dem)
% step(g)

%9a
% num=[0 0 0 50];
% dem=[1 1 0 0];
% g=tf(num,dem)
% bode(g)

%9b
% num=[0 0 20];
% dem=[1 1 0];
% g=tf(num,dem)
% bode(g)

%12
% num=[0 0 -10];
% dem=[1 11 10];
% g=tf(num,dem)
% bode(g)

%15
%num=[0 0 250];
%dem=[1 130 3000];
%g=tf(num,dem)
%bode(g)