extends Node3D

@export var animation_player_door: AnimationPlayer
@export var animation_player_drawer_1: AnimationPlayer
@export var animation_player_drawer_2: AnimationPlayer
@export var doors_are_open: bool = false
@export var drawer_is_open: bool = false

func open_doors(user:Node = null):
	if animation_player_door.is_playing(): 
			return
	if doors_are_open:
		animation_player_door.play("doors_close")
		doors_are_open = false
	else:
		animation_player_door.play("doors_open")
		doors_are_open = true

func open_drawer(user:Node = null):
	if animation_player_drawer_1.is_playing(): 
			return
	if drawer_is_open:
		animation_player_drawer_1.play("drawer_2_close")
		drawer_is_open = false
	else:
		animation_player_drawer_1.play("drawer_2_open")
		drawer_is_open = true
