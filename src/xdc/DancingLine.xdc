#===========================================================
# Xilinx Artix-7 XC7A35T-CSG324-1
# Pin assignment XDC constraint file
#===========================================================

#===========================================
# set io standard
#===========================================
set_property IOSTANDARD LVCMOS33 [get_ports]

#===========================================
# global clock & reset 
#===========================================
set_property PACKAGE_PIN V1 [get_ports reset_raw]
set_property PACKAGE_PIN P17 [get_ports clk]


#===========================================
# PS2 keyboard
#===========================================
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ps2_clk_IBUF]
set_property PACKAGE_PIN K5 [get_ports ps2_clk]
set_property PACKAGE_PIN L4 [get_ports ps2_data]

#===========================================
# VGA ports
#===========================================
set_property PACKAGE_PIN B7 [get_ports {r[3]}]
set_property PACKAGE_PIN C5 [get_ports {r[2]}]
set_property PACKAGE_PIN C6 [get_ports {r[1]}]
set_property PACKAGE_PIN F5 [get_ports {r[0]}]
set_property PACKAGE_PIN D8 [get_ports {g[3]}]
set_property PACKAGE_PIN A5 [get_ports {g[2]}]
set_property PACKAGE_PIN A6 [get_ports {g[1]}]
set_property PACKAGE_PIN B6 [get_ports {g[0]}]
set_property PACKAGE_PIN E7 [get_ports {b[3]}]
set_property PACKAGE_PIN E5 [get_ports {b[2]}]
set_property PACKAGE_PIN E6 [get_ports {b[1]}]
set_property PACKAGE_PIN C7 [get_ports {b[0]}]

set_property PACKAGE_PIN D7 [get_ports hsync]
set_property PACKAGE_PIN C4 [get_ports vsync]

#===========================================
# LED & 8-seg display ports
#===========================================
set_property PACKAGE_PIN B4 [get_ports {progressdisplay[7]}]
set_property PACKAGE_PIN A4 [get_ports {progressdisplay[6]}]
set_property PACKAGE_PIN A3 [get_ports {progressdisplay[5]}]
set_property PACKAGE_PIN B1 [get_ports {progressdisplay[4]}]
set_property PACKAGE_PIN A1 [get_ports {progressdisplay[3]}]
set_property PACKAGE_PIN B3 [get_ports {progressdisplay[2]}]
set_property PACKAGE_PIN B2 [get_ports {progressdisplay[1]}]
set_property PACKAGE_PIN D5 [get_ports {progressdisplay[0]}]
set_property PACKAGE_PIN G2 [get_ports {displaypick[2]}]
set_property PACKAGE_PIN C2 [get_ports {displaypick[1]}]
set_property PACKAGE_PIN C1 [get_ports {displaypick[0]}]
set_property PACKAGE_PIN U9 [get_ports {sample[7]}]
set_property PACKAGE_PIN V9 [get_ports {sample[6]}]
set_property PACKAGE_PIN U7 [get_ports {sample[5]}]
set_property PACKAGE_PIN U6 [get_ports {sample[4]}]
set_property PACKAGE_PIN R7 [get_ports {sample[3]}]
set_property PACKAGE_PIN T6 [get_ports {sample[2]}]
set_property PACKAGE_PIN R8 [get_ports {sample[1]}]
set_property PACKAGE_PIN T8 [get_ports {sample[0]}]
set_property PACKAGE_PIN F6 [get_ports {song_LED[1]}]
set_property PACKAGE_PIN G4 [get_ports {song_LED[0]}]
set_property PACKAGE_PIN J3 [get_ports {speed_LED[2]}]
set_property PACKAGE_PIN J2 [get_ports {speed_LED[1]}]
set_property PACKAGE_PIN K2 [get_ports {speed_LED[0]}]
set_property PACKAGE_PIN R5 [get_ports ILE]

#===========================================
# debug display
#===========================================
set_property PACKAGE_PIN G3 [get_ports {misc_debug[2]}]
set_property PACKAGE_PIN J4 [get_ports {misc_debug[1]}]
set_property PACKAGE_PIN H4 [get_ports {misc_debug[0]}]
set_property PACKAGE_PIN K1 [get_ports {debugdisplay[7]}]
set_property PACKAGE_PIN H6 [get_ports {debugdisplay[6]}]
set_property PACKAGE_PIN H5 [get_ports {debugdisplay[5]}]
set_property PACKAGE_PIN J5 [get_ports {debugdisplay[4]}]
set_property PACKAGE_PIN K6 [get_ports {debugdisplay[3]}]
set_property PACKAGE_PIN L1 [get_ports {debugdisplay[2]}]
set_property PACKAGE_PIN M1 [get_ports {debugdisplay[1]}]
set_property PACKAGE_PIN K3 [get_ports {debugdisplay[0]}]

#===========================================
# btn ports
#===========================================
set_property PACKAGE_PIN R1 [get_ports debug_switch]

#===========================================
# slew & drive & offchip_term settings
#===========================================
set_property SLEW SLOW [get_ports {r[0]}]
set_property SLEW SLOW [get_ports {r[1]}]
set_property SLEW SLOW [get_ports {r[2]}]
set_property SLEW SLOW [get_ports {r[3]}]
set_property SLEW SLOW [get_ports {g[0]}]
set_property SLEW SLOW [get_ports {g[1]}]
set_property SLEW SLOW [get_ports {g[2]}]
set_property SLEW SLOW [get_ports {g[3]}]
set_property SLEW SLOW [get_ports {b[0]}]
set_property SLEW SLOW [get_ports {b[1]}]
set_property SLEW SLOW [get_ports {b[2]}]
set_property SLEW SLOW [get_ports {b[3]}]

set_property DRIVE 12 [get_ports {r[0]}]
set_property DRIVE 12 [get_ports {r[1]}]
set_property DRIVE 12 [get_ports {r[2]}]
set_property DRIVE 12 [get_ports {r[3]}]
set_property DRIVE 12 [get_ports {b[0]}]
set_property DRIVE 12 [get_ports {b[1]}]
set_property DRIVE 12 [get_ports {b[2]}]
set_property DRIVE 12 [get_ports {b[3]}]
set_property DRIVE 12 [get_ports {g[0]}]
set_property DRIVE 12 [get_ports {g[1]}]
set_property DRIVE 12 [get_ports {g[2]}]
set_property DRIVE 12 [get_ports {g[3]}]

set_property OFFCHIP_TERM NONE [get_ports b[0]]
set_property OFFCHIP_TERM NONE [get_ports b[1]]
set_property OFFCHIP_TERM NONE [get_ports b[2]]
set_property OFFCHIP_TERM NONE [get_ports b[3]]
set_property OFFCHIP_TERM NONE [get_ports g[0]]
set_property OFFCHIP_TERM NONE [get_ports g[1]]
set_property OFFCHIP_TERM NONE [get_ports g[2]]
set_property OFFCHIP_TERM NONE [get_ports g[3]]
set_property OFFCHIP_TERM NONE [get_ports r[0]]
set_property OFFCHIP_TERM NONE [get_ports r[1]]
set_property OFFCHIP_TERM NONE [get_ports r[2]]
set_property OFFCHIP_TERM NONE [get_ports r[3]]
