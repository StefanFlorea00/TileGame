extends Node2D

onready var worldSet = $WorldSet
onready var buildingSet = $BuildingsSet
onready var selectedSet = $SelectedSet

signal on_tile_select(position)
signal on_tile_hover(position)
signal update_gui(position, building, world, selected)
signal on_use_building(position)

func update_gui(position, building, world, selected):
	emit_signal("update_gui", position, building, world, selected)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
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

