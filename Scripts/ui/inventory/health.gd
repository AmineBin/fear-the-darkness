extends Control

@export var textures: Array[Texture2D]

func _ready() -> void:
	$Sprite2D.texture = textures[3]

func update_display(current_health):
	$Sprite2D.texture = textures[current_health - 1]
	
