# ------------------------------------------------------------
# Lemmings4: Custom global placement and legalization
# ------------------------------------------------------------

set script_dir [file dirname [file normalize [info script]]]
set project_dir [file normalize [file join $script_dir ../..]]

set platform_dir "$env(HOME)/OpenROAD-flow-scripts/flow/platforms/nangate45"

set tech_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
set cell_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
set liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

# Load technology and timing information.
read_lef $tech_lef
read_lef $cell_lef
read_liberty $liberty

# Load the saved floorplan and its constraints.
read_db "$script_dir/01_floorplan.odb"
read_sdc "$script_dir/01_floorplan.sdc"

# Global placement: determine approximate standard-cell locations.
global_placement -density 0.30

# Legalization: snap cells to legal rows/sites and remove overlaps.
detailed_placement

source "$platform_dir/setRC.tcl"
# Estimate interconnect parasitics from the placement.
estimate_parasitics -placement

# Save the placement database and constraints separately.
write_db "$script_dir/02_placement.odb"
write_sdc "$script_dir/02_placement.sdc"

puts "Lemmings4 placement complete."
puts "Database saved to: $script_dir/02_placement.odb"
