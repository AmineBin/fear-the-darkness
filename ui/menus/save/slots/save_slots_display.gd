extends Control

class_name SaveSlotsDisplay

var is_open = false
@onready var play_time_label = $ColorRect/VBoxContainer/HBoxContainer/PlayTime

func _ready() -> void:
	update_visual()
	
func open():
	visible = true
	is_open = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func close():
	visible = false
	is_open = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	

func format_playtime(hours: float) -> String:
	var h = int(hours)
	var m = int((hours - h) * 60)
	var s = int(((hours - h) * 60 -m) * 60 )
	return "%dh %dmin %dsec" % [h, m, s]
	
func update_visual():
	play_time_label.text = format_playtime(SaveLoad.save_file_data.play_time)
	
func _unhandled_input(event: InputEvent) -> void:
	if is_open:
		if event.is_action_pressed("esc")  or event.is_action_pressed("toggle_inventory"):
			close()
			get_viewport().set_input_as_handled()
