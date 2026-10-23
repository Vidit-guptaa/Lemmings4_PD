# Load Nangate45 technology and cell timing information.
set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

# Load the saved floorplan and its timing constraints.
read_db "fresh_run/physical/01_floorplan.odb"
read_sdc "fresh_run/physical/01_floorplan.sdc"

# Display the design in the GUI.
puts "Loaded Lemmings4 floorplan for inspection."
