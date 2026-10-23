# ------------------------------------------------------------
# Lemmings4: Clock Tree Synthesis
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

# Load the legalized placement and its timing constraints.
read_db "$script_dir/02_placement.odb"
read_sdc "$script_dir/02_placement.sdc"

# Configure wire resistance and capacitance.
source "$platform_dir/setRC.tcl"

# Estimate the pre-CTS interconnect parasitics.
estimate_parasitics -placement

# Keep inverted-clock handling consistent with the reference flow.
repair_clock_inverters

# Build the clock tree using dedicated Nangate45 clock buffers.
clock_tree_synthesis \
    -buf_list {CLKBUF_X1 CLKBUF_X2 CLKBUF_X3} \
    -sink_clustering_enable \
    -repair_clock_nets

# Legalize cells inserted by CTS.
detailed_placement

# Estimate parasitics using the updated placement.
estimate_parasitics -placement

# Report clock-tree and timing information.
puts "\n========== CLOCK TREE =========="
report_clock_skew

puts "\n========== SETUP SLACK =========="
report_worst_slack

puts "\n========== HOLD SLACK =========="
report_worst_slack -min

puts "\n========== SETUP TNS =========="
report_tns

puts "\n========== HOLD TNS =========="
report_tns -min

# Save the post-CTS database and constraints.
write_db "$script_dir/04_cts.odb"
write_sdc "$script_dir/04_cts.sdc"

puts "\nLemmings4 CTS complete."
puts "Database saved to: $script_dir/04_cts.odb"
