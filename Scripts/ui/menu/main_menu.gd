extends Control

var button_type = null

func _on_start_pressed() -> void:
	button_type = "start"
	SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	
func _on_options_pressed() -> void:
	button_type = "settings"
	SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))
	get_tree().change_scene_to_file("res://scenes/ui/menu/settings.tscn")

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/playground.tscn")
		
