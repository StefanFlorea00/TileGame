extends Control

signal add_building()
signal delete_building()
signal use_building()
signal use2_building()

func _on_ButtonAdd_button_up():
	emit_signal("add_building")


func _on_ButtonDelete_button_up():
	emit_signal("delete_building")


func _on_ButtonUse_button_up():
	emit_signal("use_building")


func _on_ButtonUse2_button_up():
	emit_signal("use2_building")
