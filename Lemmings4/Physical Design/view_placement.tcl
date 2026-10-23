# Load Nangate45 technology and cell timing information.
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

# Load the placed design and timing constraints.
read_db "fresh_run/physical/02_placement.odb"
read_sdc "fresh_run/physical/02_placement.sdc"

puts "Loaded Lemmings4 placement for inspection."
