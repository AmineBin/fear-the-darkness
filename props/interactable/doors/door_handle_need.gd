extends StaticBody3D

@export var door_handle: MeshInstance3D
@export var is_door_handle_needed: bool

func _ready() -> void:
	if is_door_handle_needed == true:
		door_handle.visible = false
	else: 
		door_handle.visible = true
