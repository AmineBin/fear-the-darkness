extends Node3D

@onready var light:SpotLight3D = $SpotLight3D
@onready var audio_player:AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var flashlight_toggle_off:AudioStreamWAV
@export var flashlight_toggle_on:AudioStreamWAV

var battery: float = 15.0
var max_battery: float = 15.0 
var drain_rate: float = 1.0

func _ready() -> void:
	light.visible = false

func _process(delta: float) -> void:
	if battery > 0 and light.visible == true:
		battery -= drain_rate * delta
		battery = max(battery, 0.0)
		
		var current_energy:float = 1.0
		
		if battery <= 3:
			current_energy = light_dying()
			
		if battery <= 10:
			light_flicker(current_energy)
		else:
			light.light_energy = current_energy
		
	else:
		light.light_energy = 0.0 
		
func light_dying():
	var ratio = battery / max_battery
	light.light_energy = ratio * 2.0
	return 2.0 * ratio
	
func light_flicker(energy:float):
	var random_number = randi_range(1, 10)
	if random_number == 1:
		var flicker = randf_range(0.3, 1.0)
		light.light_energy = energy * flicker
	else:
		light.light_energy = energy
	
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
