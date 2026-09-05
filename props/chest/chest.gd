extends StaticBody3D

var toggle = false
var interactable = true
@export var chest_inv_ui: Control

func interact():
	print("interaction")
	var chest_open_sfx = $ChestOpen
	if chest_inv_ui.is_open == false:
		chest_open_sfx.play()
		chest_inv_ui.open(self)

func play_close_sound():
	var chest_close_sfx = $ChestClose
	chest_close_sfx.play()
