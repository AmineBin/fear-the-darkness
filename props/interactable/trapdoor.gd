extends StaticBody3D

signal change_scene

func interact(user:Node = null):
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Enter the trapdoor?", _enter_emit)

func _enter_emit():
	SaveManager.save_inventories()
	change_scene.emit()
