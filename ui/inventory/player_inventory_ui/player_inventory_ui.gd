extends Control

var inv: Inv
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	close()
	var inv_action_ui_ctrl = InvActionUi.get_node_or_null("Control")
	inv_action_ui_ctrl.discard.connect(_on_inventory_context_discard)
	inv_action_ui_ctrl.use_item.connect(_on_inventory_context_use_item)

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
	var inv_action_ui_ctrl = InvActionUi.get_node_or_null("Control")
	visible = false
	is_open = false
	inv_action_ui_ctrl.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _on_inventory_context_discard(slot: InvSlot) -> void:
	inv.discard_item_from_slot(slot)
	
func _on_inventory_context_transfer(slot: InvSlot) -> void:
	slot.transfer_item()
	inv.discard_item_from_slot(slot)

func _on_inventory_context_use_item(slot: InvSlot) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if slot and not slot.is_empty_slot():
		var was_used = slot.item.use(player)
		if was_used:
			inv.discard_item_from_slot(slot)

# Reconnecter l'inventaire	
func set_inventory(new_inv: Inv):
	inv = new_inv
	inv.update.connect(update_slots)
	update_slots()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		if !is_open:
			open()
		else:
			close()
