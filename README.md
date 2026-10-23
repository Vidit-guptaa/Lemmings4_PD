# Lemmings4 – RTL-to-GDS Physical Design

## About the Project

This project focuses on implementing the **Lemmings4 FSM (Finite State Machine)** using Verilog HDL and taking it through the RTL-to-GDS physical design flow. I used Yosys for synthesis and OpenROAD with the Nangate45 standard-cell library for the physical implementation. KLayout was used to view the final layout and perform a basic DRC check.

The main goal was to understand how an RTL design is converted into a gate-level netlist, placed and routed, and eventually exported as a GDSII layout.

## Tools Used

- **Verilog HDL** – RTL design
- **Yosys** – Logic synthesis
- **OpenROAD / OpenROAD-flow-scripts** – Physical design implementation
- **Nangate45** – Standard-cell library
- **KLayout** – Layout visualization and DRC checking
- **Ubuntu on WSL** – Development environment

## Design Flow

The project follows these main steps:

1. RTL synthesis using Yosys.
2. Floorplanning and I/O setup.
3. Standard-cell placement and legalization.
4. Clock Tree Synthesis (CTS).
5. Global routing and detailed routing.
6. Parasitic extraction and post-route timing analysis.
7. GDSII generation and layout inspection in KLayout.

## Results

| Parameter | Result |
|---|---:|
| Synthesized cell area | 117.04 µm² |
| Core area | 877.002 µm² |
| Placement-stage standard-cell area | 126.363 µm² |
| Initial placement instance count | 71 |
| Clock buffers created during CTS | 3 |
| Routed wire length | Approximately 656 µm |
| Final router-reported violations | 0 |
| GDSII file size | Approximately 106 KB |
| GDS layout dimensions | 40 µm × 40 µm |

### Timing Results

The post-route timing analysis reported the following results:

| Timing Metric | Result |
|---|---:|
| Clock period | 10 ns |
| Worst setup slack | +7.75 ns |
| Worst hold slack | +0.11 ns |
| Setup TNS | 0.00 ns |
| Hold TNS | 0.00 ns |

Both setup and hold checks passed under the timing constraints used in the flow. The hold slack is relatively small compared with the setup slack.

## Layout and DRC Check

The generated `Lemmings4.gds` file was opened and inspected using KLayout. The detailed router reported zero final routing violations.

However, the supplied KLayout DRC runset reported one **WELL.4 marker** related to well spacing. Therefore, the layout has not been confirmed to be completely DRC-clean, and the result is documented as part of the project.

## What I Learned

Through this project, I gained practical experience with:

- Synthesizing Verilog RTL into a gate-level design.
- Understanding floorplanning, placement, and clock tree synthesis.
- Following the global and detailed routing stages.
- Reading setup and hold timing reports.
- Generating and inspecting a GDSII layout.
- Understanding the difference between routing checks and layout DRC checks.

## Note

This is an educational VLSI physical design project using the Nangate45 research/testing library. The results demonstrate the implementation flow and are not intended for manufacturing signoff.
