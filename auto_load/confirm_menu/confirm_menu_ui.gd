extends Control

signal confirm

@export var click_sfx: AudioStream
@onready var label:Label = $Label
var current_action: Callable

func _on_yes_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	Control.MOUSE_FILTER_STOP
	confirm.emit()
	hide()

func _on_no_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	Control.MOUSE_FILTER_IGNORE
	hide()
	if current_action:
		confirm.disconnect(current_action)
	
func change_label(context_text):
	label.text = context_text
	
func show_context_menu(context_text, action):
	if current_action:
		confirm.disconnect(current_action)
	current_action = action
	show()
	change_label(context_text)
	confirm.connect(action, CONNECT_ONE_SHOT)
