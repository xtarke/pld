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
vcom divisor_clock.vhd tb_divisor.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clk
add wave -radix binary  /ena
add wave -radix binary  /output_5
add wave -radix binary  /output_10
#Como mostrar sinais internos do processo
add wave -radix dec /dut_5/p0/count
add wave -radix dec /dut_10/p0/count


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
