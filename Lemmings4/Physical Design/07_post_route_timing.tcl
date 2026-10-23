# ------------------------------------------------------------
# Lemmings4: Post-Route Parasitic Extraction and Timing
# ------------------------------------------------------------

set script_dir [file dirname [file normalize [info script]]]
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"
set rcx_rules "$platform_dir/rcx_patterns.rules"

# Load technology and cell data
read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

# Load detailed-routed design
read_db "$script_dir/06_detailed_route.odb"
read_sdc "$script_dir/06_detailed_route.sdc"

# Configure RC extraction
source "$platform_dir/setRC.tcl"
define_process_corner -ext_model_index 0 X
set_extraction_rules_file $rcx_rules

# Extract routed parasitics and save SPEF
extract_parasitics
write_spef "$script_dir/07_post_route.spef"

# Read extracted parasitics for timing analysis
read_spef "$script_dir/07_post_route.spef"
report_parasitic_annotation -report_unannotated

# Report timing
puts "\n========== POST-ROUTE SETUP SLACK =========="
report_worst_slack

puts "\n========== POST-ROUTE HOLD SLACK =========="
report_worst_slack -min

puts "\n========== POST-ROUTE SETUP TNS =========="
report_tns

puts "\n========== POST-ROUTE HOLD TNS =========="
report_tns -min

puts "\n========== POST-ROUTE SETUP PATH =========="
report_checks -path_delay max -format full_clock_expanded -fields {slew cap input nets fanout}

puts "\n========== POST-ROUTE HOLD PATH =========="
report_checks -path_delay min -format full_clock_expanded -fields {slew cap input nets fanout}

puts "\nPost-route parasitic extraction and timing analysis complete."
puts "SPEF: $script_dir/07_post_route.spef"
