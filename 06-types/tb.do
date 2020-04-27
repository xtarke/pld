# ============================================================================
# Name        : testbench.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom basic_rom.vhd reg16.vhd registers.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -height 15 -divider "ROM Stimulus"
add wave -label endereco /endereco
add wave -label ce /ce
add wave -label saida /saida

add wave -height 15 -divider "Registers"
add wave -label clk /clk
add wave -label clear /clear
add wave -radix hex -label address /address
add wave -label w_flag /w_flag
add wave -label data_in -radix hex /data_in

add wave -label reg_vector -radix hex /my_registers/registers

# add wave -height 15 -divider "std_logic Stimulus and Outputs"


#Simula até um 500ns
run 100ns

wave zoomfull
write wave wave.ps
