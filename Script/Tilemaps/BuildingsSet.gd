extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var used_cells
var building_cells = []
var small_building = tile_set.find_tile_by_name("Small")
var home_cell = tile_set.find_tile_by_name("Home")
var selected_cell

signal on_building_changed(money, residents, position)
signal on_building_use(position)

func on_building_changed(money, residents, position, show):
	emit_signal("on_building_changed", money, residents, position, show)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_building_nodes()
	add_home()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_2d_array(width, height, value):
	for y in range(height):
		building_cells.append([])
		building_cells[y].resize(width)

		for x in range(width):
			building_cells[y][x] = value
	return building_cells


func add_buildings_in_array():
	used_cells = get_used_cells()
	create_2d_array(15,15,0)
	for tile in used_cells.size():
		building_cells[used_cells[tile].x][used_cells[tile].y] = 15
	print(building_cells)

func add_building_nodes():
	used_cells = get_used_cells_by_id(small_building)
	var home_cells = get_used_cells_by_id(home_cell)
	var home: Home = Home.new()
	home.setPosition(home_cells[0].x, home_cells[0].y)
	building_cells.append(home)
	for tile in used_cells.size():
		var building: Building = Building.new()
		building.setPosition(used_cells[tile].x, used_cells[tile].y)
		building.money = 15
		building.id = tile+1
		building_cells.append(building)
	print(building_cells)

func add_home():
	pass

func get_selected_cells():
	return get_used_cells()

func get_building_array():
	return building_cells

func get_building_cell(position):
	return get_cellv(position)

func get_building_node(position):
	for building in building_cells.size():
		if(building_cells[building].position == position):
			return building_cells[building]

func _on_World_on_tile_select(position):
	print("SELECTED BUILDINGS:" , get_building_node(position))
	selected_cell = position
	if(get_building_node(position)):
		on_building_changed(get_building_node(position).money, get_building_node(position).residents, map_to_world(position), true)		
	else:
		on_building_changed(0,0,Vector2(0,0),false)
	return get_building_node(position)


func _on_Menu_add_building():
	pass # Replace with function body.


func _on_World_on_use_building():
	if(get_building_node(selected_cell)):
		get_building_node(selected_cell).use()
