extends Control

var current_slot: InvSlot
var is_from_chest = false
@export var transfer_context_button: Button

signal use_item
signal discard
signal transfer

func _ready() -> void:
	visible = false
	
# Afficher le menu context
func show_menu(slot, visual_slot):
	if not slot or slot.is_empty_slot():
		return
	current_slot = slot
	if current_slot.item:
		global_position = visual_slot.get_global_position() + Vector2(visual_slot.size.x, 0)
		visible = true

func _on_use_pressed() -> void:
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Use " + current_slot.item.name + " ?", _use_emit)

func _use_emit():
	use_item.emit(current_slot)
	hide()

func _on_discard_pressed() -> void:
	var confirm_control = ConfirmMenuUi.get_node_or_null("Control")
	confirm_control.show_context_menu("Discard " + current_slot.item.name + " ?", _discard_emit)

func _discard_emit():
	discard.emit(current_slot)
	hide()

func _on_cancel_pressed() -> void:
	hide()

func _on_transfer_pressed() -> void:
	transfer.emit(current_slot)
	hide()
