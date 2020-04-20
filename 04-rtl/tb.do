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
vcom latch1.vhd reg1.vhd tb_register_latch.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -height 15 -divider "Stimulus"
add wave -radix binary  /clk
add wave -radix binary  /d
add wave -radix binary  /data

add wave -height 15 -divider "Register signals"
add wave /dut/a
add wave /dut/b
add wave /dut/q
add wave -height 15 -divider "Latch signals"
add wave /latch_1/gate
add wave /latch_1/q

#Simula até um 500ns
run 100ns

wave zoomfull
write wave wave.ps
