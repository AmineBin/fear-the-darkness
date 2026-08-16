extends Control

@onready var inv: Inv = preload("res://resources/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

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
	
