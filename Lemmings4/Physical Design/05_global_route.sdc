###############################################################################
# Created by write_sdc
# Thu Oct 22 22:33:27 2026
###############################################################################
current_design Lemmings4
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {bump_left}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {bump_right}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dig}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ground}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {aaah}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {digging}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {walk_left}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {walk_right}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 5.0000 [get_ports {aaah}]
set_load -pin_load 5.0000 [get_ports {digging}]
set_load -pin_load 5.0000 [get_ports {walk_left}]
set_load -pin_load 5.0000 [get_ports {walk_right}]
###############################################################################
# Design Rules
###############################################################################
