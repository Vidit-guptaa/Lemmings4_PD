import pya

layout = pya.Layout()
layout.read("/mnt/d/vlsi/codes/Lemmings4/fresh_run/physical/Lemmings4.gds")

print("GDS_READ_OK")
print("Database unit (um):", layout.dbu)
print("Top-level cells:")
for cell in layout.top_cells():
    print(" ", cell.name)
print("Total cells:", layout.cells())
print("Top-level cell count:", len(list(layout.top_cells())))
