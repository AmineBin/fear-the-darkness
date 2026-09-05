extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: String

func use(target: Node) -> bool:
	return true

func can_discard() -> bool:
	return true
	
func transfer() -> void:
	pass
	
