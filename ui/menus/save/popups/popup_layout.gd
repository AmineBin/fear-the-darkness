extends NinePatchRect

func _on_close_pressed() -> void:
	get_parent().hide()
	print("hide")

func _on_reduce_pressed() -> void:
	get_parent().hide()
	print("hide")
