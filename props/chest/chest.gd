extends StaticBody3D

var toggle = false
var interactable = true

func interact(user:Node = null):
	var chest_open_sfx = $ChestOpen
	if ChestInventoryUi.is_open == false:
		chest_open_sfx.play()
		ChestInventoryUi.open(self)

func play_close_sound():
	var chest_close_sfx = $ChestClose
	chest_close_sfx.play()
