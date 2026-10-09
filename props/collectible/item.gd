extends Area3D

@export var item: InvItem

func _ready() -> void:
	if str(get_path()) in SaveManager.save_file_data.picked_up_items:
		queue_free()

func interact(user: Node = null) -> void:
	if not user.has_method("collect"):
		return
	if user.collect(item):
		SaveManager.save_file_data.picked_up_items.append(str(get_path()))
		queue_free()
