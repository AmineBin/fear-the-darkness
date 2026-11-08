extends StaticBody3D

func interact(user: Node = null) -> void:
	if owner and owner.has_method("interact"):
		owner.interact(user)
