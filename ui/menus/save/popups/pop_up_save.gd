extends Control

@onready var save_validate: Label = $PopUp/Label2
@onready var slot_buttons: Array[Button] = [
	$PopUp/GridContainer2/SlotButton1,
	$PopUp/GridContainer2/SlotButton2,
	$PopUp/GridContainer2/SlotButton3,
	$PopUp/GridContainer2/SlotButton4
]
var save_slot = 1
func _ready() -> void:
	for i in slot_buttons.size():
		var button = slot_buttons[i]
		# Le slot change en fonction du bouton sélectionné
		button.pressed.connect(select_save_slot.bind(i + 1))
		
func select_save_slot(i):
	save_slot = i
	print(save_slot)
		
func _on_close_pop_up_button_pressed() -> void:
	hide()

func _on_pop_up_button_no_pressed() -> void:
	hide()

func _on_pop_up_button_yes_pressed() -> void:
	SaveManager.save_all(save_slot)
	#save_validate.show()
	#save_validate.text = "Data save complete, you can turn off your device safely."
