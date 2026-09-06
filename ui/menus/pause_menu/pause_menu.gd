extends Control

@export var inventory_ui: Control
@export var chest_inventory_ui: Control
@export var pause_menu_ui: Control
@export var click_sfx: AudioStream

@export var settings_scene: PackedScene

func _ready() -> void:
	hide()

func resume():
	get_tree().paused = false
	hide()
	$AnimationPlayer.play_backwards("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func ui_opened():
	if inventory_ui.visible:
		return true
	else: 
		return false
		
func _on_resume_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	resume()

func _on_quit_menu_pressed() -> void:
	get_tree().paused = false
	SoundPlayer.audio_play(click_sfx)
	get_tree().change_scene_to_packed(settings_scene)
	
func _on_quit_desktop_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()
	
func _on_settings_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	hide()
	pause_menu_ui.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") && inventory_ui.is_open == false && chest_inventory_ui.is_open == false && settings_scene.visible == false:
		if get_tree().paused:
			resume()
			print("esc")
		else:
			pause()
			print("esc")
