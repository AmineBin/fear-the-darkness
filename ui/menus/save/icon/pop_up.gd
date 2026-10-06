extends Control

signal save

func _on_close_pop_up_button_pressed() -> void:
	hide()


func _on_pop_up_button_no_pressed() -> void:
	hide()

func _on_pop_up_button_yes_pressed() -> void:
	save.emit()
