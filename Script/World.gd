extends Node2D

onready var worldSet = $WorldSet
onready var buildingSet = $BuildingsSet
onready var selectedSet = $SelectedSet

var noise
var map_size = Vector2(80,60)
var map_cap = 0.3
var road_caps = Vector2(0.2, 0.05)
var building_caps = Vector2(0.1, 0.01)
var environment_caps = Vector3(1, 0.05, 0.08)

signal on_tile_select(position)
signal on_tile_hover(position)
signal update_gui(position, building, world, selected)
signal on_use_building(position)
signal on_map_generated()

func update_gui(position, building, world, selected):
	emit_signal("update_gui", position, building, world, selected)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 2
	noise.period = 12
	noise.lacunarity = 2
	noise.persistence = 0.7
	make_world_map()
#	make_road_map()
#	make_building_map()
	make_environment_map()
	make_fill_rest()
	emit_signal("on_map_generated")
	
func make_world_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < map_cap:
				worldSet.set_grass_tile(Vector2(x,y))
				
				
func make_road_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < road_caps.x and a > road_caps.y:
				buildingSet.set_road(Vector2(x,y))
	
func make_building_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < building_caps.x and a > building_caps.y and buildingSet.get_cellv(Vector2(x,y))!=16:
				buildingSet.set_building(Vector2(x,y))
	
func make_environment_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < environment_caps.x and a > environment_caps.y or a < environment_caps.z:
				var chance = randi() % 100
				if chance < 15:
					if(worldSet.get_cellv(Vector2(x,y))==worldSet.grass_tile):
						buildingSet.set_cellv(Vector2(x,y),6)

onready var water_tile = worldSet.tile_set.find_tile_by_name("Water")
func make_fill_rest():
	for x in map_size.x:
		for y in map_size.y:
			if worldSet.get_cellv(Vector2(x,y))==-1:
				worldSet.set_cellv(Vector2(x,y),water_tile)
	
	
func _unhandled_input(event):
	
	var world_mouse_pos = worldSet.get_local_mouse_position()
	var world_tile_pos = worldSet.world_to_map(world_mouse_pos)
	
	emit_signal("on_tile_hover", world_tile_pos)
	update_gui(world_tile_pos, buildingSet.get_building_cell(world_tile_pos), worldSet.get_world_cell(world_tile_pos), selectedSet.get_selected())

	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			if(worldSet.get_cellv(world_tile_pos)!=-1):
				emit_signal("on_tile_select", world_tile_pos)

func _on_Menu_use_building():
	emit_signal("on_use_building")

