extends StaticBody3D

var is_audio_playing = false
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#audio_player.play()
	is_audio_playing = true

func interact(user:Node = null):
	if is_audio_playing == true:
		audio_player.stop()
		is_audio_playing = false
	else:
		audio_player.play()
		is_audio_playing = true
