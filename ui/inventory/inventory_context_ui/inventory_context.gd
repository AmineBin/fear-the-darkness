extends Control

var current_slot: InvSlot
var is_from_chest = false
@export var transfer_context_button: Button

signal use_item
signal discard
signal transfer

# Afficher le menu context
func show_menu(slot, is_chest_interface, from_chest):
	if is_chest_interface == true:
		transfer_context_button.visible = true
	current_slot = slot
	is_from_chest = from_chest
	if current_slot.item:
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
