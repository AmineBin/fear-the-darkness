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
	use_item.emit(current_slot)
	hide()

func _on_discard_pressed() -> void:
	print("bouton appuyé")
	discard.emit(current_slot)
	hide()

func _on_cancel_pressed() -> void:
	hide()

func _on_transfer_pressed() -> void:
	transfer.emit(current_slot)
	hide()
