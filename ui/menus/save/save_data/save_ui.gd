extends SaveSlotsDisplay

func _on_save_pressed() -> void:
	SaveLoad.save_all()
	close()
