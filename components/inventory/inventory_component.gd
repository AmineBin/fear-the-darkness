extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

# Ajouter un item dans l'inventaire
func insert(item: InvItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	update.emit()
	
func has_item(requested_item):
	for slot in slots:
		if slot.item == requested_item && slot.item != null:
			return true
	return false
	
func discard_item(slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot():
		slot.discard_item()
		update.emit()
		
func transfer_item(target_inv: Inv, slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot() and target_inv:
		var item_to_transfer = slot.item
		var success = target_inv.insert(item_to_transfer)
		if success:
			slot.discard_item()
			update.emit()
