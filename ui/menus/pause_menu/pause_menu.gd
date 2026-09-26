extends Control

@export var inventory_ui: Control
@export var chest_inventory_ui: Control
@export var click_sfx: AudioStream

@onready var settings_ui: Control = $Settings
@export_file("*.tscn") var main_menu_scene_path: String

var context_text = ""

func _ready() -> void:
	hide()

func resume():
	if PauseGame.is_game_paused == true:
		PauseGame.resume_game()
		hide()
		settings_ui.visible = false
		$AnimationPlayer.play_backwards("blur")
	
func pause():
	if PauseGame.is_game_paused == false:
		PauseGame.pause_game()
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
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_menu_pressed() -> void:
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Quit to menu?", _quit_to_menu)

func _quit_to_menu():
	SoundPlayer.audio_play(click_sfx)
	hide()
	settings_ui.visible = false
	get_tree().paused = false
	SaveManager.reset_save_data()
	get_tree().change_scene_to_file(main_menu_scene_path)

func _on_quit_desktop_pressed() -> void:
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Quit to desktop?", _quit_to_desk)
	
func _quit_to_desk():
	SoundPlayer.audio_play(click_sfx)
	get_tree().quit()
	
func _on_settings_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	settings_ui.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") :
		if PauseGame.is_game_paused == true:
			resume()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			pause()
