extends SaveSlotsDisplay

func _on_save_pressed() -> void:
	SaveManager.save_all()
	close()
