extends Control

signal on_pos_changed(position)
signal on_building_changed(position)
signal on_world_changed(position)
signal on_selected_changed(position)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func on_pos_changed(position):
	emit_signal("on_pos_changed", position)

func on_building_changed(position):
	emit_signal("on_building_changed", position)
	
func on_world_changed(position):
	emit_signal("on_world_changed", position)
	
func on_selected_changed(position):
	emit_signal("on_selected_changed", position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_World_update_gui(position, building, world, selected):
	on_pos_changed(position)
	on_building_changed(building)
	on_world_changed(world)
	on_selected_changed(selected)
