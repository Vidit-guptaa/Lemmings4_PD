
set script_dir [file dirname [file normalize [info script]]]
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

set tech_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
set cell_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
set liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

read_lef $tech_lef
read_lef $cell_lef
read_liberty $liberty

#CTS design and constraints
read_db "$script_dir/04_cts.odb"
read_sdc "$script_dir/04_cts.sdc"

source "$platform_dir/setRC.tcl"

#Routing Layers
set_routing_layers -signal metal2-metal10
set_routing_layers -clock metal4-metal10

#golbal routing adjustments
set_global_routing_layer_adjustment metal2-metal3 0.5
set_global_routing_layer_adjustment metal4-metal10 0.25

pin_access
global_route \
    -congestion_iterations 30 \
    -congestion_report_file "$script_dir/05_congestion.rpt"

estimate_parasitics -global_routing

puts "\n========== SETUP SLACK =========="
report_worst_slack

puts "\n========== HOLD SLACK =========="
report_worst_slack -min

puts "\n========== SETUP TNS =========="
report_tns

puts "\n========== HOLD TNS =========="
report_tns -min

write_db "$script_dir/05_global_route.odb"
write_sdc "$script_dir/05_global_route.sdc"

puts "\nLemmings4 global routing complete."
puts "Database: $script_dir/05_global_route.odb"
