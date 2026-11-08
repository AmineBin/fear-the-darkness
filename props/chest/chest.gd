extends StaticBody3D

var toggle = false
var interactable = true

func interact(user:Node = null):
	var player_inv_ui = get_tree().get_first_node_in_group("player_inv_ui")
	if player_inv_ui.is_open == false:
		var chest_open_sfx = $ChestOpen
		if ChestInventoryUi.is_open == false:
			chest_open_sfx.play()
			ChestInventoryUi.open(self)

func play_close_sound():
	var chest_close_sfx = $ChestClose
	chest_close_sfx.play()
