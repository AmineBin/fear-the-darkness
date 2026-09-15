extends Area3D

@export var item: InvItem

func _ready() -> void:
	if str(get_path()) in SaveManager.save_file_data.picked_up_items:
		queue_free()

func interact(user: Node = null) -> void:
	if user.has_method("collect"):
		SaveManager.save_file_data.picked_up_items.append(str(get_path()))
		user.collect(item)
		queue_free()
