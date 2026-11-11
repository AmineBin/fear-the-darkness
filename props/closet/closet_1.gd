extends Node3D

@export var animation_player: AnimationPlayer
@export var doors_are_open: bool = false

func open_doors(user:Node = null):
	if doors_are_open:
		animation_player.play("doors_close")
		doors_are_open = false
	else:
		animation_player.play("doors_open")
		doors_are_open = true
