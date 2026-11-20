extends Control

signal confirm

@export var click_sfx: AudioStream
@onready var label:Label = $Label
var current_action: Callable
var capture_mouse_on_close := true

var is_open = false

func open():
	visible = true
	is_open = true
	if capture_mouse_on_close:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	PauseGame.pause_game()

func close():
	visible = false
	is_open = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	PauseGame.resume_game()

func _on_yes_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	close()
	confirm.emit()
	current_action = Callable()

func _on_no_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	close()
	if current_action and confirm.is_connected(current_action):
		confirm.disconnect(current_action)
	current_action = Callable()
	
func change_label(context_text):
	label.text = context_text
	
func show_context_menu(context_text: String, action: Callable, capture_mouse := true):
	open()
	if current_action and confirm.is_connected(current_action):
		confirm.disconnect(current_action)
	current_action = action
	capture_mouse_on_close = capture_mouse
	change_label(context_text)
	confirm.connect(action, CONNECT_ONE_SHOT)
