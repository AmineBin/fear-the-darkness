extends Control

@export var inv: Inv
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@export var player: CharacterBody3D

var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()

# Mettre à jour les slots
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
# Ouvrir l'inventaire		
func open():
	visible = true
	is_open = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Fermer l'inventaire	
func close():
	var context_menu = $VBoxContainer/InventoryContext
	visible = false
	is_open = false
	context_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if is_open:
		if event.is_action_pressed("esc"):
			close()
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("toggle_inventory") && !is_open:
		open()
	elif event.is_action_pressed("toggle_inventory") && is_open:
		close()
		
func _on_inventory_context_discard(slot: InvSlot) -> void:
	inv.discard_item(slot)
	
func _on_inventory_context_transfer(slot: InvSlot) -> void:
	slot.transfer_item()
	inv.discard_item(slot)

func _on_inventory_context_use_item(slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot():
		var was_used = slot.item.use(player)
		
		if was_used:
			inv.discard_item(slot)
