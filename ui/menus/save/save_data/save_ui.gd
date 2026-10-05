extends SaveSlotsDisplay

@onready var pop_up: Control = $PopUp

func _on_save_pressed() -> void:
	SaveManager.save_all()
	close()
	
func _on_save_icon_button_pressed() -> void:
	pop_up.show()
