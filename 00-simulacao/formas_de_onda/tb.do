# ============================================================================
# Name        : tb.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom testbench.vhd

#Simula
vsim -voptargs="+acc" -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary -label clk /clk
add wave -radix binary -label reset /rst
add wave -radix binary -label irregular_uma_vez /x
add wave -radix binary -label irregular_repete /y
add wave -radix hex -label multi_bit /z

add wave -radix binary -label juca /z

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps

 
