extends Control

@export var pause_menu: Control
@export var click_sfx: AudioStream
@export_file("*.tscn") var main_menu_scene_path: String
@export_file("*.tscn") var game_scene_path: String

var button_type = null

func _on_back_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	if get_tree().paused:
		hide()
		pause_menu.show()
	else:
		get_tree().change_scene_to_file(main_menu_scene_path)
		
func _on_save_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			hide()
			pause_menu.show()
			get_viewport().set_input_as_handled()
