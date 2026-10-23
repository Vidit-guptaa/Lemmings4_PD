read_db 06_detailed_route.odb

set block [ord::get_db_block]
set die [$block getDieArea]

puts "Design: [$block getName]"
puts "DBU per micron: [$block getDbUnitsPerMicron]"
puts "Die bounds (DBU): [$die xMin] [$die yMin] [$die xMax] [$die yMax]"

exit
