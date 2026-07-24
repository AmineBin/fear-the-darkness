extends Node3D

var room_scene = load("res://scenes/rooms/room1.tscn")

func _ready():
	var instance = room_scene.instantiate()
	$CurrentRoom.add_child(instance)
	
func change_room(room_path, camera_node, spawn_node):
	# supprimer tout les enfants de la room actuelle
	for  children in $CurrentRoom.get_children():
		children.queue_free()
	
	# charger et instancer la room
	var instance = load(room_path)
	var room = instance.instantiate()
	$CurrentRoom.add_child(room)
	
	var camera = room.find_child(camera_node)
	# changer la camera actuelle
	camera.make_current()
	
	var spawn = room.find_child(spawn_node)
	$Player.global_position = spawn.global_position
	
	print("je change de camera pour la target camera")
	
