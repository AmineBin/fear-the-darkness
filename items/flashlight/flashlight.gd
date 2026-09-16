extends Node3D

@onready var light:SpotLight3D = $SpotLight3D
@onready var audio_player:AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var flashlight_toggle_off:AudioStreamWAV
@export var flashlight_toggle_on:AudioStreamWAV

func _ready() -> void:
	light.visible = false
	
	
func flashlight_on():
	light.visible = true
	audio_player.stream = flashlight_toggle_on
	audio_player.play()
	
func flashlight_off():
	light.visible = false
	audio_player.stream = flashlight_toggle_off
	audio_player.play()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_flashlight"):
		if light.visible:
			flashlight_off()
		else:
			flashlight_on()
