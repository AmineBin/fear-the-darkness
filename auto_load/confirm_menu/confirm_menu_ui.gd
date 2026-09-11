extends Control

signal confirm

func _on_yes_pressed() -> void:
	confirm.emit()
	hide()

func _on_no_pressed() -> void:
	hide()
