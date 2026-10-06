extends SaveSlotsDisplay

@onready var pop_up_save: Control = $PopUp
@onready var pop_up_load_data: Control = $PopUpLoadData

@export var curseur:CompressedTexture2D

func _ready() -> void:
	Input.set_custom_mouse_cursor(curseur, Input.CURSOR_ARROW, Vector2(0, 0))

func _on_save_pressed() -> void:
	SaveManager.save_all()
	close()
	
func _on_save_icon_button_pressed() -> void:
	pop_up_save.show()
	
func _on_save_icon_button_2_pressed() -> void:
	pop_up_load_data.show()
	
