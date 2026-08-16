extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var item_type: String
@export var heal_amount: int

func use_item(player):
	if item_type == "heal":
		player.regain_health(heal_amount)
		print(player.health)
