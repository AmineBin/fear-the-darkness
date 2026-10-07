extends Control

@export var textures: Array[Texture2D]
@onready var health_sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	if not player or textures.is_empty():
		return
	var health_component := player.get_node_or_null("HealthComponent") as HealthComponent
	if not health_component:
		return
	health_component.health_changed.connect(_on_health_changed)

func _on_health_changed(current_health: int) -> void:
	health_sprite.texture = textures[current_health - 1]
