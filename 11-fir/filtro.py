"""
Exemplo para validação do filtro média móvel em Python.
    - teste.dec contém um tom em 400Hz e outro em 3.2kHz gerados pelo ocenaudio

Refs:
    - https://www.gaussianwaves.com/2010/11/moving-average-filter-ma-filter-2/
    - https://www.ocenaudio.com/
"""

import numpy as np
from scipy import signal

hexdata = []

with open("teste.dec", "r",encoding="utf-8") as f:
    data = f.readlines()

    for i in data:
        hexdata.append(int((i.replace('\n',''))))

L=4                     # L-point filter
b = (np.ones(L))/L      # numerator co-effs of filter transfer function
a = np.ones(1)          # denominator co-effs of filter transfer function
y = signal.convolve(hexdata,b) # filter output using convolution
# y = signal.lfilter(b,a,hexdata) #filter output using lfilter function

with open('filtro_python.dec','w', encoding="utf-8") as f:
    for i in y:
        f.write(str(int(i)))
        f.write('\n')
