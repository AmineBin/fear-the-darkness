extends Control

@export var player_inv: Inv
@export var chest_inv: Inv
@onready var chest_slots: Array = $NinePatchRect/ChestGridContainer.get_children()
@onready var player_slots: Array = $NinePatchRect/PlayerGridContainer.get_children()
@export var player: CharacterBody3D

var current_chest_node

var is_open = false

func _ready():
	player_inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(player_inv.slots.size(), player_slots.size())):
		player_slots[i].update(player_inv.slots[i])
	for i in range(min(chest_inv.slots.size(), chest_slots.size())):
		chest_slots[i].update(chest_inv.slots[i])
			
func open(chest):
	current_chest_node = chest
	visible = true
	is_open = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func close():
	visible = false
	is_open = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	
	
func _unhandled_input(event: InputEvent) -> void:
	if is_open:
		if event.is_action_pressed("esc")  or event.is_action_pressed("toggle_inventory"):
			close()
			get_viewport().set_input_as_handled()
			
	if event.is_action_pressed("toggle_inventory") && is_open:
		close()
	
func _on_inventory_context_discard(current_slot: InvSlot) -> void:
	if current_slot in player_inv.slots:
		player_inv.discard_item(current_slot)
	elif current_slot in chest_inv.slots:
		chest_inv.discard_item(current_slot)
	
func _on_inventory_context_transfer(current_slot: InvSlot) -> void:
	if current_slot in player_inv.slots:
		player_inv.transfer_item(chest_inv, current_slot)
	elif current_slot in chest_inv.slots:
		chest_inv.transfer_item(player_inv, current_slot)

func _on_inventory_context_use_item(current_slot: InvSlot) -> void:
	if current_slot and not current_slot.is_empty_slot():
		var was_used = current_slot.item.use(player)
		
		if was_used:
			if current_slot in player_inv.slots:
				player_inv.discard_item(current_slot)
			elif current_slot in chest_inv.slots:
				chest_inv.discard_item(current_slot)
