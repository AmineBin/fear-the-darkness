extends SaveSlotsDisplay

@onready var slot_buttons: Array[Button] = [
	$ColorRect/GridContainer2/Button1,
	$ColorRect/GridContainer2/Button2,
	$ColorRect/GridContainer2/Button3,
	$ColorRect/GridContainer2/Button4
]

var save_slot = 1

func _ready() -> void:
	super._ready()
	
	for i in slot_buttons.size():
		var button = slot_buttons[i]
		# Le slot change en fonction du bouton sélectionné
		button.pressed.connect(select_save_slot.bind(i + 1))


func select_save_slot(i):
	save_slot = i
	print(save_slot)
	
func _on_load_pressed() -> void:
	SaveManager.load_all(save_slot)

func _on_delete_pressed() -> void:
	pass # Replace with function body.
