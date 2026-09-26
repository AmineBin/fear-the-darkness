extends StaticBody3D


func interact(user:Node = null):
	
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Enter the trapdoor?", _enter_emit)

func _enter_emit():
	print("j'entre dans la trappe")
