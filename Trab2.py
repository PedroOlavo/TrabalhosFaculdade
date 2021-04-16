# -*- coding: utf-8 -*-
"""
Created on Tue Dec  3 14:03:22 2019

@author: mathe
"""

import random 
import math
import numpy as np
random.seed(0)
np.random.seed(0)

#FUNÇÕES

#VARIÁVEIS DE ENTRADA
Nvar = 4
Nnos = 5
Mintermos = [1,3,5]
print("Mintermos =", Mintermos)

#Codificação das portas:
#100 --> AND
#200 --> OR
#300 --> XOR

a=bin(1)
a=list(a)
print(a)
#TABELA VERDADE
tv=np.zeros([2**Nvar, Nvar+1+Nnos+1], dtype=int)
print(tv)
#Entradas
for i in range(2**Nvar):
    a=bin(i)
    a=list(a)
    a=a[2:]
    #print(a)
    b=np.zeros(Nvar, dtype=int)
    for j in range(len(a)):
        aux=a[len(a)-1-j]
        b[Nvar-j-1]=int(aux)
    for j in range(len(b)):
        tv[i,j]=b[j]
print(tv)
#Saída
for i in range (len(Mintermos)):
    a=Mintermos[i]
    tv[a, Nvar]=1
print('Tabela Verdade:')
print(tv)

#Gerar indivíduo inicial
ind=np.zeros(3*Nnos+1, dtype=int)
n=Nvar
i=0
while (i<3*Nnos):
    ind[i]=np.random.randint(n)
    i=i+1
    ind[i]=np.random.randint(n)
    i=i+1
    ind[i]=np.random.randint(1,4)*100
    i=i+1
    n=n+1
print(ind)
ind[len(ind)-1]=np.random.randint(Nnos)+Nvar
print(ind)



