extends Control

var button_type = null
@export var click_sfx: AudioStream
@export_file("*.tscn") var settings_scene_path: String
@export_file("*.tscn") var game_scene_path: String

func _on_start_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_file(game_scene_path)
	
func _on_options_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().change_scene_to_file(settings_scene_path)

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()

func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file(game_scene_path)
