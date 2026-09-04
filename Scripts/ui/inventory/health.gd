extends Control

@export var textures: Array[Texture2D]
@onready var health_sprite = $Sprite2D

func _ready() -> void:
	health_sprite.texture = textures[3]

func update_display(current_health: int) -> void:
	health_sprite.texture = textures[current_health - 1]
	
