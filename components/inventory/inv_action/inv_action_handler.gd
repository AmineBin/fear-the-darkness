extends Node

@export var player: CharacterBody3D
var slot: InvSlot
var inv_ui: Control

func _ready() -> void:
	inv_ui = owner as Control

func _on_inventory_context_use_item(slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot():
		var was_used = slot.item.use(player)
		
		if was_used:
			slot.amount -= 1
			if slot.amount <= 0:
				inv_ui.update_slots()

func _on_inventory_context_discard(slot: InvSlot) -> void:
	if !slot.is_empty_slot():
		slot.discard_item()
		inv_ui.update_slots()
	
func _on_inventory_context_transfer(slot: InvSlot) -> void:
	if !slot.is_empty_slot():
		slot.transfer_item()
		inv_ui.update_slots()
