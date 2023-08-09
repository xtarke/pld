"""
Exemplo para validação do filtro média móvel em Python.
    - teste440_2000.hex contém um tom em 400Hz e outro em 2kHz gerados pelo ocenaudio

Refs:
    - https://www.gaussianwaves.com/2010/11/moving-average-filter-ma-filter-2/
    - https://www.ocenaudio.com/
"""

import numpy as np
from scipy import signal
import matplotlib.pyplot as plt
# import scipy.signal as sc


def converte_hex_sinalizado(hexval):
    """ Converte número hex (string) de 8 bits para inteiro com sinal """
    bits = 8
    val = int(hexval, 16)
    if val & (1 << (bits-1)):
        val -= 1 << bits
    return val

hexdata = []

with open("teste440_2000.hex", "r",encoding="utf-8") as f:
    data = f.readlines()

    for i in data:
        hex_string = i.replace('\n','').replace('t','')
        hexdata.append(converte_hex_sinalizado(hex_string))


L=4                     # L-point filter
b = (np.ones(L))/L      # numerator co-effs of filter transfer function
a = np.ones(1)          # denominator co-effs of filter transfer function
# y = signal.convolve(hexdata,b) # filter output using convolution
y = signal.lfilter(b,a,hexdata) #filter output using lfilter function


# Gera a resposta em frequência do filtro
ordem=4
[w,h]=signal.freqz(1/ordem*np.ones(ordem), 1, fs=8000)
plt.plot(w,20*np.log10(abs(h)));plt.show()


with open('filtro_python.dec','w', encoding="utf-8") as f:
    for i in y:
        f.write(str(int(i)))
        f.write('\n')
