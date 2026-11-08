extends SaveSlotsDisplay

@onready var pop_up_save: Control = $PopUpSave
	
func _on_save_icon_button_pressed() -> void:
	pop_up_save.show()
