#******************************************************************************
#                                                                             *
#                  Copyright (C) 2016 IFSC                                    *
#                                                                             *
#                                                                             *
# All information provided herein is provided on an "as is" basis,            *
# without warranty of any kind.                                               *
#                                                                             *
# File Name: tb.do          							    				  *
#                                                                             *
#                                                                             *
# REVISION HISTORY:                                                           *
#  Revision 0.1.0    25/02/2017 - Initial Revision                            *
#******************************************************************************

vlib work
vcom testbench.vhd uart_rx.vhd uart_tx.vhd

vsim -t ns work.testbench

# view wave
add wave -radix binary /clk
add wave -radix binary /rst

add wave /u1/state_fsm
add wave /u1/ser_data
add wave /u1/bits
add wave -label sre /u1/shift_reg_en 

# add wave /u0/datainReg
# add wave /u0/index

add wave /en
add wave -radix binary -label data /data
add wave -label serialData /serialData
add wave -label done /done


run 80 us

wave zoomfull
write wave wave.ps




