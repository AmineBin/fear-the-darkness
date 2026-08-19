extends Node2D

var button_type = null

func _on_start_pressed() -> void:
	button_type = "start"
	$Confirm.play()
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	
	
func _on_options_pressed() -> void:
	button_type = "options"
	$Confirm.play()
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")

func _on_quit_pressed() -> void:
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	$Confirm.play()
	await $Confirm.finished
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/playground.tscn")
	elif button_type == "options":
		get_tree().change_scene_to_file("")
