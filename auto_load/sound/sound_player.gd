extends Node

func audio_play(stream):
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
