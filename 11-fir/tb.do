# ============================================================================
# Name        : tb_divisor.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim para divisor de clock
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom fir.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clk
add wave -radix binary  /rst
add wave -height 15 -divider "Sinais internos do fir"
add wave -radix dec /dut/reg
add wave -height 15 -divider "Entrada e saida"
add wave -radix dec /x
add wave -radix dec /y

add wave -radix hex /dados_arquivo




#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
