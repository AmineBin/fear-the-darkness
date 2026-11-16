extends StaticBody3D

@export var target: Node = null

@export var method_name: StringName = "interact"

func interact(user: Node = null) -> void:
	var node = target
	if !target:
		node = owner
	if node and node.has_method(method_name):
		node.call(method_name, user)
