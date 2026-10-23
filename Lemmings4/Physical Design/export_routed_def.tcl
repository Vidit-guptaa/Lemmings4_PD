set platform_dir "/flow/platforms/nangate45"

read_lef "$platform_dir/lef/NangateOpenCellLibrary.tech.lef"
read_lef "$platform_dir/lef/NangateOpenCellLibrary.macro.mod.lef"
read_liberty "$platform_dir/lib/NangateOpenCellLibrary_typical.lib"

read_db "06_detailed_route.odb"
read_sdc "06_detailed_route.sdc"

write_def "06_detailed_route.def"
exit
