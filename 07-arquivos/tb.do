# ============================================================================
# Name        : tb.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================


vlib work
vcom txt_util.vhdl
vcom rom_file.vhd
vcom file_out.vhd
vcom file_in.vhd
vcom files_tb.vhd

vsim -t ns work.files_tb

view wave
add wave /clk
add wave -radix dec /counter
add wave -height 15 -divider "Dados lidos do arquivo"
add wave -radix dec /file_in_data
add wave -height 15 -divider "Dados da ROM carregados externamente"
add wave -radix hex /rom_data

run 200 ns

wave zoomfull
