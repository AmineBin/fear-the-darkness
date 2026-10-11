extends Control

@export var textures: Array[Texture2D]
@onready var health_sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("player")
var health_component: HealthComponent

func _ready() -> void:
	if not player or textures.is_empty():
		return
	health_component = player.get_node_or_null("HealthComponent") as HealthComponent
	if not health_component:
		return
	health_component.health_changed.connect(_on_health_changed)

func _on_health_changed(current_health: int) -> void:
	var texture_index = clampi(health_component.max_health - current_health, 0, textures.size() - 1)
	health_sprite.texture = textures[texture_index]
