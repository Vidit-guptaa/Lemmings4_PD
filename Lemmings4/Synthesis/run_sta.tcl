read_liberty /home/vidit/OpenROAD-flow-scripts/flow/platforms/nangate45/lib/NangateOpenCellLibrary_typical.lib

read_verilog yosys_results/mapped/Lemmings4_mapped.v

link_design Lemmings4

read_sdc yosys_results/mapped/Lemmings4.sdc

report_checks -path_delay max -format full_clock_expanded -group_path_count 10
report_worst_slack -max
report_checks -path_delay min -format full_clock_expanded -group_path_count 10
report_worst_slack -min
