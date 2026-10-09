extends Control

@export var click_sfx: AudioStream
@export var settings_scene: PackedScene
@export var game_scene: PackedScene
@export var save_load_scene: PackedScene

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_packed(game_scene)

func _on_load_save_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_packed(save_load_scene)
	
func _on_options_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().change_scene_to_packed(settings_scene)

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()
