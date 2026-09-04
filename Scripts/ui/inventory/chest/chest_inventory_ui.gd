extends Control

@onready var player_inv: Inv = preload("res://resources/inventory/player_inventory.tres")
@onready var chest_inv: Inv = preload("res://resources/inventory/chest_inventory.tres")
@onready var chest_slots: Array = $NinePatchRect/ChestGridContainer.get_children()
@onready var player_slots: Array = $NinePatchRect/PlayerGridContainer.get_children()
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
	
