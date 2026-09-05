extends Node3D

@onready var hit_rect = get_node("/root/Playground/GUI/PlayerGUI/ColorRect")
@onready var health_node = get_node("/root/Playground/Inventory/Inv_UI/VBoxContainer/Health")

func _on_player_player_hit(current_health: int) -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
	
	health_node.update_display(current_health)
	
