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
vcom my_package.vhd soma_sub_proc.vhd name_overload.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -height 15 -divider "Integer Stimulus"
add wave -label ai /ai
add wave -label bi /bi
add wave -label ci /ci
add wave -height 15 -divider "Real Stimulus"
add wave -label ar /ar
add wave -label br /br

add wave -height 15 -divider "Outpus"
add wave -label si /si
add wave -label ti /ti
add wave -label sr /sr
add wave -label som_con /som_con
add wave -label sub_con /sub_con
add wave -label max_out /max_out
add wave -label min_out /min_out

add wave -height 15 -divider "std_logic Stimulus and Outputs"
add wave -label a_logic /a_logic
add wave -label b_logic /b_logic
add wave -label sum /sum

#Simula até um 500ns
run 100ns

wave zoomfull
write wave wave.ps
