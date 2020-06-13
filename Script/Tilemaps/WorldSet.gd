extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grass_tile = tile_set.find_tile_by_name("Grass")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_world_cell(position):
	return get_cellv(position)
	
func set_grass_tile(position):
	return set_cellv(position, grass_tile)

func _on_World_on_tile_select(position):
	print("SELECTED WORLD:" , get_cellv(position))
	return get_cellv(position)
