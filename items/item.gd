extends Area3D

@export var item: InvItem
@export var required_item: InvItem
@export var message_to_display: String

func _ready() -> void:
	if str(get_path()) in SaveManager.save_file_data.picked_up_items:
		queue_free()

func interact(user: Node = null) -> void:
	if not user.has_method("collect"):
		return
	if required_item && not user.inv.has_item(required_item):
		if user and user.has_method("display_message"):
			user.display_message(message_to_display)
		return
	elif user.collect(item):
		SaveManager.save_file_data.picked_up_items.append(str(get_path()))
		queue_free()
		
			
		
