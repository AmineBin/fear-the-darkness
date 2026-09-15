extends Button

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_text: Label = $CenterContainer/Panel/Label
var current_slot_item: InvSlot

# Mettre à jour le slot actuel
func update(slot: InvSlot):
	current_slot_item = slot
	if !current_slot_item || !current_slot_item.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = current_slot_item.item.texture
		amount_text.visible = true
		amount_text.text = str(current_slot_item.amount)

# Afficher le menu context
func _on_pressed() -> void:
	var inv_action_ui_ctrl = InvActionUi.get_node_or_null("Control")
	inv_action_ui_ctrl.show_menu(current_slot_item, self)
