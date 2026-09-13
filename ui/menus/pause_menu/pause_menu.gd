extends Control

@export var inventory_ui: Control
@export var chest_inventory_ui: Control
@export var click_sfx: AudioStream

@onready var settings_ui: Control = $Settings
@export_file("*.tscn") var main_menu_scene_path: String

var is_game_paused = false 
func _ready() -> void:
	hide()

func resume():
	get_tree().paused = false
	hide()
	settings_ui.visible = false
	$AnimationPlayer.play_backwards("blur")
	is_game_paused = false
	
func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	is_game_paused = true
	
func ui_opened():
	if inventory_ui.visible:
		return true
	else: 
		return false
		
func _on_resume_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	resume()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_menu_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	hide()
	settings_ui.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_scene_path)
	
func _on_quit_desktop_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()
	
func _on_settings_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	settings_ui.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") && inventory_ui.is_open == false && ChestInventoryUi.is_open == false:
		if is_game_paused:
			resume()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			pause()
		
		
