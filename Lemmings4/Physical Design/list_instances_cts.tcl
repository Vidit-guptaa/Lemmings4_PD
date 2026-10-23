set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_db "fresh_run/physical/04_cts.odb"

set block [ord::get_db_block]
set fp [open "fresh_run/physical/cts_instances.txt" "w"]

foreach inst [$block getInsts] {
    puts $fp "[$inst getName] | [[$inst getMaster] getName]"
}

close $fp
puts "Saved post-CTS instance list."
