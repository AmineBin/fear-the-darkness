extends Control

var current_slot: InvSlot

func show_menu(slot):
	visible = true
	current_slot = slot

func _on_cancel_pressed() -> void:
	visible = false
	
func _on_use_pressed() -> void:
	var player_node = get_node("/root/Main/Player")
	var inventory_node = get_node("/root/Main/Player/CanvasLayer/Inv_UI")
	if player_node.health != 4:
		current_slot.item.use_item(player_node)
		current_slot.discard_item()
		inventory_node.update_slots()
		visible = false
	else: 
		print("PV déjà au max")

func _on_discard_pressed() -> void:
	var inventory_node = get_node("/root/Main/Player/CanvasLayer/Inv_UI")
	current_slot.discard_item()
	inventory_node.update_slots()
	visible = false
