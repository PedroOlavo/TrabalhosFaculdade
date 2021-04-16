# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 10:53:23 2019

@author: 026800
"""
"""usar rand para gerar maior e menor
n_termos=2*(maior-menor)+1    /////será a quantidade de operadores, a diferença de 3 em relaçao ao individuo é para serem feitas as comparações
n_termos e pra gerar um vetor numerico auxiliar para gerar os resultados da direita e da esquerda
num[0] vai usar o operador ind[0] com o num[1], depois o res vai usar o ind[1] com o num[2] e assim por diante"""
"""codigo"""
import random 
import math
import numpy as np
random.seed(0)
np.random.seed(0)
#%%
"""Variaveis do AG"""
tam_pop=10
num_op=4 #1=+, 2=-, 3=* , 4=/
maior=5
menor=1
tam_torn=3
gmax=100
g=0
"""Variaveis axuiliares"""
tam_ind=(maior-menor)*2+4
n_termos=2*(maior-menor)+1
"""criação do vetor numerico"""
num=np.zeros(n_termos, dtype=int)
aux=maior
for i in range (maior):
    num[i]=aux
    aux=aux-1 
aux=menor+1
for i in range (maior, n_termos):
    num[i]=aux
    aux=aux+1
"""criação da população inicial"""
pop_in=np.random.randint\
(low=1,high=num_op+1,size=(tam_pop, tam_ind)) #low,high e size são opcionais
pop_in[:,2*(maior-menor):]=0
for i in range(tam_pop):
    igualdade=random.randint(0,tam_ind-5)
    pop_in[i][igualdade]=500
print(pop_in)
#%%
"""Função soma"""
def soma(x, y):
    return x+y
"""Função Subtração"""
def sub(x, y):
    return x-y
"""Função Multiplicação"""
def mult(x, y):
    return x*y
"""Função Divisão"""
def div(x, y):
    return x/y
#%%
"""Função Resultado"""
def resultado(operador, x, y):
    if operador==1:
        return x+y
    elif operador==2:
        return x-y
    elif operador==3:
        return x*y
    elif operador==4:
        return x//y
#"""era o jeito que eu fiz a avaliação, porem nao era uma função"""
#for i in range(tam_pop):
#    ind=[]    
#    ind[:]=pop_in[i,:] #ind ta recebendo a 1 linha da matriz da população
#    p_igual=ind.index(500) #atribui o valor do lugar onde esta o igual
#    print('p_igual', p_igual)
#    ind_e=ind[0:p_igual] #retorna os valores a esquerda do igual
#    ind_d=ind[p_igual+1:tam_ind-4] #retorna os valores a direita do igual
#    print('ind', ind)
#    print('ind_e', ind_e)
#    print('ind_d', ind_d) 
#    res_e=num[0]
#    for j in range(len(ind_e)):
#        print('iteração', j)
#        print('ind[i]', ind[j])
#        print('num[i+1]', num[j+1])
#        print('ressultado da esquerda', res_e)
#        res_e=resultado(ind_e[j],res_e,num[j+1])
#    print("resultado da esquerda" ,res_e)
#                    
#    res_d=num[len(ind_e)+1]
#    for j in range(len(ind_d)):
#        print('iteração', j)
#        print('ind[i]', ind[maior+j+2])
#        print('res_esquerda', res_e)
#        res_d=resultado(ind_d[j],res_d,num[p_igual+1+j])
#    print('resultado da direita', res_d)
#    ind[n_termos]=res_e
#    ind[n_termos+1]=res_d
#    erro=(res_e)-(res_d)
#    ind[n_termos+2]=erro
#    pop_in[i,:]=ind[:]
#    print("erro", erro)
#    print("ind" ,ind)
#"""Função dos pais, aqui foi meu torneio mas apenas com 2 pais"""
#%%
def avaliacao(vet, tam_ind, num, resultado):
    ind = []
    ind[:]=vet[:]
    p_igual=ind.index(500)
    ind_e=ind[0:p_igual]
    res_e=num[0]
    for i in range(len(ind_e)):
        res_e=resultado(ind_e[i],res_e, num[i+1])
    ind_d=ind[p_igual+1:tam_ind-4]
    num_d=num[p_igual+1:]
    res_d=num_d[0]
    for i in range(len(ind_d)):
        res_d=resultado(ind_d[i],res_d,num_d[i+1])
    erro=math.fabs((res_e)-(res_d))
    return res_e, res_d, erro
#k1=pop_in[1,:]
#a1=avaliacao(k1,tam_ind,num,resultado)
#a1=avaliacao(, tam_ind, num, resultado)
#def pais (tam_pop,pop_in):
#    pai1=[]
#    pai2=[]
#    pai_um1=pop_in[np.random.randint(tam_pop),:]
#    pai_um2=pop_in[np.random.randint(tam_pop),:]
#    while (pai_um1.all==pai_um2.all):
#        pai_um2=pop_in[np.random.randint(tam_pop),:]
#    if (pai_um1[tam_ind-1] < pai_um2[tam_ind-1]):
#        pai1[:]=pai_um1[:]
#    else:
#        pai1[:]=pai_um2[:]
#    pai_dois1=pop_in[np.random.randint(tam_pop),:]
#    pai_dois2=pop_in[np.random.randint(tam_pop),:] 
#    while(pai_dois1.all==pai_dois2.all):
#        pai_dois2=pop_in[np.random.randint(tam_pop),:]
#    if (pai_dois1[tam_ind-1] < pai_dois2[tam_ind-1]):
#        pai2[:]=pai_dois1[:]
#    else:
#        pai2[:]=pai_dois2[:]
#    return [pai1,pai2]
#%%
def torneio(tam_torn,pop):
    ncp=pop.shape[1]
    torneio=[]
    while len(torneio) != tam_torn:
        r=random.randint(0,tam_pop-1)
        if r not in torneio:
            torneio.append(r)
    pai=pop[torneio[0],:]
    i_pai=torneio[0]
    for i in range(tam_torn-1):
        if pop[torneio[i+1],ncp-1]<pai[ncp-1]:
            pai[:]=pop[torneio[i+1],:]
            i_pai=torneio[i+1]
    return(i_pai)
#ps=pais(tam_pop,pop_in)
#p1=ps[0]
#p2=ps[1]
#e1=avaliacao(p1[:],len(p1), num, resultado)
#%%
def mutacao (ind, num_op, resultado, avaliacao):
    filho=ind[:]
    tam_ind=len(filho)
    print("filho", filho)
    im=random.randint(0, tam_ind-4)
    while(filho[im]==500):
        im=random.randint(0, tam_ind-4)
    filho[im]=random.randint(1,num_op)
    print("filho", filho)
    filho[tam_ind-3:tam_ind]= \
    avaliacao(filho[:], tam_ind, num, resultado)
    print("filho", filho)
    return(filho)
#%%
def detecta_pior(pop, tam_ind, tam_pop):
    pior=[0, pop[0, tam_ind-1]]
    for i in range(tam_pop-1):
        if(pop[i+1, tam_ind-1]>pior[1]):
            pior=[i+1, pop[i+1, tam_ind-1]]
    return pior
#%%
for i in range(tam_pop):
    pop_in[i, tam_ind-3:tam_ind]= \
    avaliacao(pop_in[i,:],tam_ind, num, resultado)
print("pop_in", pop_in)
i_pai=torneio(tam_torn,pop_in)
i_pai2=i_pai
while (i_pai2==i_pai):
    i_pai2=torneio(tam_torn,pop_in)
print("i_pai", i_pai)
print("i_pai2", i_pai2)
pai1=pop_in[i_pai,:]
pai2=pop_in[i_pai2,:]

filho=mutacao \
(pop_in[i_pai,:],num_op,resultado,avaliacao)
pior=detecta_pior(pop_in,tam_ind,tam_pop)
print("pior", pior)
if filho[tam_ind-1]< pop_in[i_pai, tam_ind-1]:
    pop_in[i_pai, :]=filho
    print("nova pop", pop_in)
while(filho[tam_ind-1]!=0 and g<gmax):
    g=g+1
    print("G=**********", g)
    i_pai=torneio(tam_torn, pop_in)
    print("i_pai = ", i_pai)
    filho=mutacao(pop_in[i_pai, :], \
                  num_op, resultado, avaliacao)
    pior = detecta_pior(pop_in, tam_ind, tam_pop)
    print("pior=", pior)
    if filho[tam_ind-1] <= pior[1]:
        pop_in[pior[0], :]=filho
        print("nova pop=", pop_in)
print("G =************************", g)
print("pop_final =", pop_in)
#%% cruzamento
def cruzamento(pai1, pai2 , resultado, avaliacao):
    c=0
    while c!=1:
        indc=[]
        z=random.randint(0,tam_ind-5) #ponto de corte
        print(z)
        for i in range (tam_ind):
            indc.append(0)
        for i in range (z):
            indc[i]=pai1[i]
        for i in range(z, tam_ind): ##a quantidade que pegaria do segundo pai seria tam_ind-nuemero sorteado
            indc[i]=pai2[i] ##depois verificaria se tem o 500, se nao tem ou se tem 2 500
        for i in range(tam_ind):
            if indc[i]==500:
                c=c+1
    indc[tam_ind-3:tam_ind]= avaliacao(indc,tam_ind, num, resultado)
    indc[tam_ind-4]=indc.index(500)
    return indc
#%%       
incr=cruzamento(pai1, pai2 , resultado, avaliacao)         
print(incr)
print(pai1)
print(pai2)