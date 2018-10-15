# ============================================================================
# Name        : tb.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================


vlib work
vcom file_out.vhd
vcom file_in.vhd
vcom files_tb.vhd

vsim -t ns work.files_tb

view wave
add wave -radix dec /dado

run 50 ns
