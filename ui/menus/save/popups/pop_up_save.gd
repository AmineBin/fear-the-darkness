extends Control

@onready var save_validate: Label = $PopUp/Label2

func _on_close_pop_up_button_pressed() -> void:
	hide()

func _on_pop_up_button_no_pressed() -> void:
	hide()

func _on_pop_up_button_yes_pressed() -> void:
	SaveManager.save_all()
	save_validate.show()
	save_validate.text = "Data save complete, you can turn off your device safely."
	
