# ------------------------------------------------------------
# Lemmings4: Post-CTS timing analysis
# ------------------------------------------------------------

set script_dir [file dirname [file normalize [info script]]]
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

set tech_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
set cell_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
set liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

# Load technology and timing information.
read_lef $tech_lef
read_lef $cell_lef
read_liberty $liberty

# Load the post-CTS design and constraints.
read_db "$script_dir/04_cts.odb"
read_sdc "$script_dir/04_cts.sdc"

# Configure wire resistance and capacitance.
source "$platform_dir/setRC.tcl"

# Estimate interconnect parasitics from placement.
estimate_parasitics -placement

# Report setup timing.
puts "\n========== WORST SETUP SLACK =========="
report_worst_slack

puts "\n========== SETUP TIMING PATHS =========="
report_checks -path_delay max -group_path_count 5 \
    -fields {slew cap input net fanout} \
    -format full_clock_expanded

# Report hold timing.
puts "\n========== WORST HOLD SLACK =========="
report_worst_slack -min

puts "\n========== HOLD TIMING PATHS =========="
report_checks -path_delay min -group_path_count 5 \
    -fields {slew cap input net fanout} \
    -format full_clock_expanded

# Report aggregate timing.
puts "\n========== SETUP TNS =========="
report_tns

puts "\n========== HOLD TNS =========="
report_tns -min

# Report clock skew.
puts "\n========== CLOCK SKEW =========="
report_clock_skew

puts "\nPost-CTS timing analysis complete."
