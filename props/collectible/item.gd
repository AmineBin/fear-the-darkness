extends Area3D

@export var item: InvItem

func interact(user: Node = null) -> void:
	if user.has_method("collect"):
		user.collect(item)
		queue_free()
