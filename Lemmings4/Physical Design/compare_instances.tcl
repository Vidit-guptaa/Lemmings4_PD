set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"

read_db "fresh_run/physical/02_placement.odb"
set before [ord::get_db_block]
set before_names {}
foreach inst [$before getInsts] {
    lappend before_names [$inst getName]
}

read_db "fresh_run/physical/04_cts.odb"
set after [ord::get_db_block]

puts "\nInstances present after CTS but absent before:"
foreach inst [$after getInsts] {
    set name [$inst getName]
    if {[lsearch -exact $before_names $name] < 0} {
        puts "$name | [[$inst getMaster] getName]"
    }
}
