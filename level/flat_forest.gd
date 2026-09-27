extends Node3D

@export_file("*.tscn") var level1: String

func _on_change_scene():
	get_tree().change_scene_to_file(level1)
