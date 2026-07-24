extends StaticBody3D

@export var target_room: String
@export var target_spawn: String
@export var target_camera: String

func interact():
	var main = get_node("/root/Main")
	if target_room && target_camera && target_spawn != null:
		main.change_room(target_room, target_camera, target_spawn)
