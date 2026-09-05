extends Control

var button_type = null
@export var click_sfx: AudioStream
@export var settings_scene: PackedScene
@export var game_scene: PackedScene

func _on_start_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_packed(game_scene)
	
func _on_options_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().change_scene_to_packed(settings_scene)

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()

func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_packed(game_scene)
