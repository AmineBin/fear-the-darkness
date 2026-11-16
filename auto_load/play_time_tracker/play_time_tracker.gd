extends Node

var play_time: float = 0.0

func _process(delta: float) -> void:
	play_time += delta/3600
