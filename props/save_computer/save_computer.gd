extends StaticBody3D

@export var save_ui: Control

func interact(user:Node = null):
	save_ui.open()
