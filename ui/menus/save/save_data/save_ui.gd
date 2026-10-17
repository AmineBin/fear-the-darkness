extends SaveSlotsDisplay

@onready var pop_up_save: Control = $PopUp
@onready var pop_up_load_data: Control = $PopUpLoadData
	
func _on_save_icon_button_pressed() -> void:
	pop_up_save.show()
