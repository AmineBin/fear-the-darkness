extends Control

@export var pause_menu: Control

var button_type = null

func _on_back_pressed() -> void:
	SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))
	if get_tree().paused:
		hide()
		pause_menu.show()
	else:
		get_tree().change_scene_to_file("res://scenes/ui/menu/main_menu.tscn")
		
func _on_save_pressed() -> void:
	SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			hide()
			pause_menu.show()
			get_viewport().set_input_as_handled()
