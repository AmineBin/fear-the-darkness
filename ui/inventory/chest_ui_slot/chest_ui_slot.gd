extends Button

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_text: Label = $CenterContainer/Panel/Label
@export var context_menu: Control

var current_slot_item: InvSlot
var is_chest_interface = true

@export var is_from_chest: bool = false

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

func _on_pressed() -> void:
	context_menu.show_menu(current_slot_item, is_chest_interface, is_from_chest)
