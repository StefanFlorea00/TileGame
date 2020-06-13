extends Control

signal on_money_changed(money)
signal on_residents_changed(residents)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func on_money_changed(money):
	emit_signal("on_money_changed", money)

func on_residents_changed(residents):
	emit_signal("on_residents_changed", residents)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_BuildingsSet_on_building_changed(money, residents, position, show):
	on_money_changed(money)
	on_residents_changed(residents)
#	set_position(position)
	if(show==false):
		self.hide()
	else:
		self.show()
