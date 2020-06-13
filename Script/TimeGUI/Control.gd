extends Control

signal on_time_changed(time)
signal on_state_changed(state)

func on_time_changed(time):
	emit_signal("on_time_changed", time)

func on_state_changed(state):
	emit_signal("on_state_changed", state)


func _on_CanvasModulate_time_passed(time):
	on_time_changed(time)
