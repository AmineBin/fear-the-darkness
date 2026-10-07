extends Control

@export var click_sfx: AudioStream
@export_file("*.tscn") var settings_scene_path: String
@export_file("*.tscn") var game_scene_path: String
@export_file("*.tscn") var save_load_scene_path: String

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_file(game_scene_path)

func _on_load_save_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_file(save_load_scene_path)
	
func _on_options_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().change_scene_to_file(settings_scene_path)

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()
