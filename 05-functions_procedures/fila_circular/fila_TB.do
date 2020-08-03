vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom fila.vhd fila_TB.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.fila_TB

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix unsigned -label dado_out /dado_out
add wave -radix unsigned -label fila /fila_inst


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps