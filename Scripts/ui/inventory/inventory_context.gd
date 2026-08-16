extends Control

var current_slot: InvSlot
var is_from_chest = false

# Afficher le menu context
func show_menu(slot, is_chest_interface, from_chest):
	if is_chest_interface == true:
		var inventory_context_button_node = get_node("/root/Playground/Player/ChestInventory/ChestInventoryUi/InventoryContext/HBoxContainer/Transfer")
		inventory_context_button_node.visible = true
	current_slot = slot
	is_from_chest = from_chest
	if current_slot.item:
		visible = true

func _on_cancel_pressed() -> void:
	visible = false

# Utiliser l'item actuel
func _on_use_pressed() -> void:
	var player_node = get_node("/root/Playground/Player")
	var inventory_node = get_node("/root/Playground/Player/Inventory/Inv_UI")
	var chest_inventory_node = get_node("/root/Playground/Player/ChestInventory/ChestInventoryUi")
	if player_node.health != 4:
		current_slot.item.use_item(player_node)
		current_slot.discard_item()
		inventory_node.update_slots()
		chest_inventory_node.update_slots()
		visible = false
	else: 
		print("PV déjà au max")

# Jeter l'item actuel
func _on_discard_pressed() -> void:
	var inventory_node = get_node("/root/Playground/Player/Inventory/Inv_UI")
	var chest_inventory_node = get_node("/root/Playground/Player/ChestInventory/ChestInventoryUi")
	current_slot.discard_item()
	inventory_node.update_slots()
	chest_inventory_node.update_slots()
	visible = false
	
func _on_transfer_pressed() -> void:
	var chest_inventory_ui_node = get_node("/root/Playground/Player/ChestInventory/ChestInventoryUi")
	var player_inventory_ui_node = get_node("/root/Playground/Player/Inventory/Inv_UI")
	
	var chest_inventory = preload("res://resources/inventory/chest_inventory.tres")
	var player_inventory = preload("res://resources/inventory/player_inventory.tres")
	
	if is_from_chest == true:
		player_inventory.insert(current_slot.item)
		current_slot.discard_item()
		chest_inventory_ui_node.update_slots()
		player_inventory_ui_node.update_slots()
		visible = false
	else:
		chest_inventory.insert(current_slot.item)
		current_slot.discard_item()
		chest_inventory_ui_node.update_slots()
		player_inventory_ui_node.update_slots()
		visible = false
	
