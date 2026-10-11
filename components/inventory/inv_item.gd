extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: String
@export var max_amount: int
@export var can_be_used: bool

func use(target: Node) -> bool:
	if can_be_used == true:
		return true
	else:
		return false

func can_discard() -> bool:
	return true
	
func transfer() -> void:
	pass
	
