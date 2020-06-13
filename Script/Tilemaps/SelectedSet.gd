extends TileMap

var selected_tile = tile_set.find_tile_by_name("Selected")
var hover_tile = tile_set.find_tile_by_name("Hover")
var empty_tile = -1

var last_selected_tile
var last_hover_tile = Vector2(0,0)

func _ready():
	pass # Replace with function body.
	
func set_selected(position):
	if(get_used_cells_by_id(selected_tile).size()<1 ):
		set_cellv(position,selected_tile)
	elif(get_used_cells_by_id(selected_tile).size()>=1):
		print("LAST TILE", last_selected_tile)
		set_cellv(last_selected_tile,empty_tile)
		set_cellv(position,selected_tile)
	last_selected_tile = position
	
func set_hover(position):
	if(position != last_hover_tile):
		if(get_cellv(position)!=selected_tile):
			set_cellv(position,hover_tile)
		if(get_cellv(last_hover_tile)==hover_tile):
			set_cellv(last_hover_tile,empty_tile)
	last_hover_tile = position

func get_selected():
	return get_used_cells_by_id(selected_tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_World_on_tile_select(position):
	set_selected(position)
	print("SELECTED TILE:", get_selected())



func _on_World_on_tile_hover(position):
	set_hover(position)
