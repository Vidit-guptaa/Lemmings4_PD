set platform_dir "/home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_db "fresh_run/physical/02_placement.odb"

set block [ord::get_db_block]
puts "Pre-CTS instance count: [llength [$block getInsts]]"

set count 0
foreach inst [$block getInsts] {
    if {[string match "clkbuf*" [$inst getName]]} {
        puts "Unexpected clock buffer: [$inst getName]"
        incr count
    }
}
puts "Pre-CTS clock-buffer count: $count"
