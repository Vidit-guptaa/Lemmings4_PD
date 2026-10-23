# ------------------------------------------------------------
# Lemmings4: Detailed Routing Checkpoint Viewer
# ------------------------------------------------------------

set script_dir [file dirname [file normalize [info script]]]
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

read_db "$script_dir/06_detailed_route.odb"
read_sdc "$script_dir/06_detailed_route.sdc"

puts "\n========== DETAILED ROUTING CHECKPOINT LOADED =========="
puts "Design: [ord::get_db_block]"
puts "Checkpoint: $script_dir/06_detailed_route.odb"
puts "Detailed-routing geometry is ready for inspection."
