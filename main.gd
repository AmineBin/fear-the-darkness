extends Node3D

var room_scene = load("res://scenes/rooms/room1.tscn")

func _ready():
	$FadeTransition/AnimationPlayer.play("fade_out")
	var instance = room_scene.instantiate()
	$CurrentRoom.add_child(instance)
	
func change_room(room_path, spawn_node, animation_node):
	var animation = $CurrentRoom.get_child(0).find_child("AnimationPlayer")
	var colorect = $CurrentRoom.get_child(0).find_child(animation_node)
	colorect.show()
	# supprimer tout les enfants de la room actuelle
	for  children in $CurrentRoom.get_children():
		children.queue_free()
	
	# charger et instancier la room
	var instance = load(room_path)
	var room = instance.instantiate()
	$CurrentRoom.add_child(room)
	
	
	
	# changer la position du joueur pour le spawn de la room
	var spawn = room.find_child(spawn_node)
	$Player.global_position = spawn.global_position
	
	var new_colorect = room.find_child("OpenDoorFadeTransition")
	var new_animation = room.find_child("AnimationPlayer")
	new_colorect.show()
	new_animation.play("fade_out")
	
	
	
