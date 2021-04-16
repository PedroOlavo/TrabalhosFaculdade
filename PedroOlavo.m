fs=19737;%frequência de amostragem%
load sinal.mat
N=length(sinal);
fi=(-N/2:N/2)*(fs/N);
fi=fi(1:end-1);
J=fft(sinal);%%fft do sinal%%
A=fftshift(J);%%centrar as componentes de frequencia nula e redistribuir o grafico%%
%%
C=abs(A);%%magnitude de A que é a fft do sinal%%
K=angle(A);%%da a fase da fft do sinal em radianos, que é oq queremos%%
plot(fi,20*log10(C)) %%o 20log10 é pra colocar o gráfico em escala de dB%%
title('Resposta em Magnitude')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
xlim([-0.5 0.5]*fs)
figure
plot(fi,K, 'g')
title('Resposta de fase')
xlabel('Frequência (Hz)')
ylabel('Fase (rad)')
xlim([-0.5 0.5]*fs)
%% Fir
fp=650;%% Frequência de passagem%%
fc=1400;%%Frequência de bloqueio%%
rp=0.08;%%riple na banda de passagem, em dB%%
rc=60;%%riple na rejeição, em dB%
ep=10^(-rp/20);%%normalizando a atenuação%%
es=10^(-rc/20);%%normalizando a atenuação%%
[n,Wn,beta,ftype] = kaiserord([fp fc],[1 0],[ep es],fs);%%calculando ordem do filtro%%
fffir=fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
[x,f]=freqz(fffir,1,N/2);
figure
plot(f*(fs/(2*pi)),20*log10(abs(x)))
title('Resposta em Magnitude (FIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
xlim([0 0.5]*(fs))
grid
figure
plot(f*(fs/(2*pi)),angle(x), 'g')
title('Resposta de fase (FIR)')
xlabel('Frequência (Hz)')
ylabel('Fase (rad)')
xlim([0 0.5]*(fs))
grid
figure
% filtrando sinal
F1=filter(fffir,1,Sinal_D);%%sinal filtrado%%
F1fir=fft(F1);%%fft do sinal filtrado, passar pro dominio da frequencia%%
F1firs=fftshift(F1fir);%%centrando na frequência 0%%
mgF1=abs(F1firs);%%magnitude do sinal filtrado%%
faF1=angle(F1firs);%%fase do sinal filtrado%%
plot(fi,20*log10(mgF1), 'g')
title('Resposta em Magnitude Sinal Filtrado(FIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
xlim([-0.5 0.5]*(fs))
figure
plot(fi,faF1)
title('Resposta de Fase Sinal Filtrado(FIR)')
xlabel('Frequência (Hz)')
ylabel('Fase')
xlim([-0.5 0.5]*(fs))
figure
%% atraso de grupo
atrFir=grpdelay(fffir,1,fs);
plot(linspace(0,pi,length(atrFir))*(fs/(2*pi)),atrFir)
title('Atraso de Grupo  (Filtro FIR)')
xlabel('Frequência (Hz)')
ylabel('Atraso de Grupo (Amostras)')
grid
xlim([0 0.5]*(fs))
figure
%%Plotando os sinais juntos%%
SOpltx=Sinal_D(n+1:end-ceil(atrFir(1)));
Filplotx=F1(n+1+ceil(atrFir(1)):end);
plot((0:length(SOpltx)-1)*(1/fs),SOpltx,(0:length(SOpltx)-1)*(1/fs),Filplotx)
title('Sinal original e Filtrado(FIR)')
xlabel('Tempo(s)');
ylabel('Amplitude do Sinal')
legend('Sinal Original','Sinal Filtrado - FIR')
%% Filtro IIR
fp=650;%%frequencia na banda de passagem%%
fc=1350;%%frequencia na banda de rejeição%%
rp=0.04;%%riple na banda de passagem em dB%%
rc=60;%%riple na banda de rejeição em dB%%
gp=10^(-rp/20);%%normalizando a atenuação%%
gc=10^(-rc/20);%%normalizando a atenuação%%
wp=tan(pi*fp/fs);%%normalizando a frequencia%%
wac=tan(pi*fc/fs);%%normalizando a frequencia%%
e=sqrt((1/gp)^2-1);%caldulo do e%
a=1/gc;%calculo de A%
ordem=log10(sqrt(a^2-1)/e)/log10(wac/wp);%%calculando ormde do filtro%%
ordem=ceil(ordem);
wc=wp/(e^(1/ordem));%%calculo da frequencia de corte%%
[b,a]=butter(ordem,wc,'s');
%aplicando bilinear%
[bz,az]=bilinear(b,a,0.5);
[h,f]=freqz(bz,az,N/2);
figure
plot(f*(fs/(2*pi)),20*log10(abs(h)))
title('Resposta em magnitude(IIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
xlim([0 0.5]*(fs))
grid
figure
plot(f*(fs/(2*pi)),angle(h), 'g')
title('Resposta de fase (IIR)')
xlabel('Frequência (Hz)')
ylabel('Fase(rad)')
xlim([0 0.5]*(fs))
grid
figure
%filtrando o sinal%
filtrado1iir=filter(bz,az,Sinal_D);
filtrado1fftiir=fft(filtrado1iir);
filtrado1fftshiftiir=fftshift(filtrado1fftiir);
magfiltrado1iir=abs(filtrado1fftshiftiir);
fasefiltrado1iir=angle(filtrado1fftshiftiir);
plot(fi,20*log10(magfiltrado1iir))
title('Resposta em Magnitude - Sinal Filtrado(IIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
xlim([-0.5 0.5]*(fs))
figure
plot(fi,fasefiltrado1iir)
title('Resposta em Fase - Sinal Filtrado (IIR)')
xlabel('Frequência (Hz)')
ylabel('Fase (rad)')
xlim([-0.5 0.5]*(fs))
figure
% atraso de grupo
atrasofiltroIIR=grpdelay(bz,az,fs);
plot(linspace(0,pi,length(atrasofiltroIIR))*(fs/(2*pi)),atrasofiltroIIR)
title('Atraso de Grupo (IIR)')
xlabel('Frequência (Hz)')
ylabel('Atraso de grupo (Amostras)')
xlim([0 0.5]*(fs))
grid
figure
%%elegeu-se a media dos atrasos, pois nao e constante%%
atrasoiir=sum(atrasofiltroIIR(1:ceil(length(atrasofiltroIIR)*(2*fp/fs))))/ceil(length(atrasofiltroIIR)*(2*fp/fs));
%%grafico sinal original e filtrado%%
soriginalplotx=Sinal_D(ordem+1:end-32);
filtrado1iirplotx=filtrado1iir(ordem+1+32:end);
plot((0:length(soriginalplotx)-1)*(1/fs),soriginalplotx,(0:length(soriginalplotx)-1)*(1/fs)-0.000355,filtrado1iirplotx)
title('Sinal original e Filtrado (IIR)')
xlabel('Tempo(s)');
ylabel('Amplitude do Sinal')
legend('Sinal Original','Sinal Filtrado(IIR)')
%% Plotando as resposta em freq para verificar atenuação
figure
subplot(3,1,1)
plot(fi,20*log10(C))
title('Resposta em Magnitude Sinal Original')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
grid
xlim([-0.5 0.5]*(fs))
subplot(3,1,2)
plot(fi,20*log10(mgF1))
title('Resposta em Magnitude (FIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
grid
xlim([-0.5 0.5]*(fs))
subplot(3,1,3)
plot(fi,20*log10(magfiltrado1iir))
title('Resposta em Magnitude (IIR)')
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
grid
xlim([-0.5 0.5]*(fs))
figure
plot(fi,K, 'g')
title('Resposta de Fase - Sinal Original')
xlabel('Frequência (Hz)')
ylabel('Fase(rad)')
grid
xlim([-0.5 0.5]*(fs))
figure
plot(fi,faF1, 'g')
title('Resposta de Fase  - Sinal Filtrado FIR')
xlabel('Frequência (Hz)')
ylabel('Fase(rad)')
grid
xlim([-0.5 0.5]*(fs))
figure
plot(fi,fasefiltrado1iir, 'g')
title('Resposta de Fase - Sinal Filtrado IIR')
xlabel('Frequência (Hz)')
ylabel('Fase(rad)')
grid
xlim([-0.5 0.5]*(fs))

