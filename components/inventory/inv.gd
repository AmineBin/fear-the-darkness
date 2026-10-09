extends Resource

class_name Inv

signal update

var inv_full

@export var slots: Array[InvSlot]

func _init(nb_slots: int = 12):
	for i in range(nb_slots):
		slots.append(InvSlot.new())
		
# Ajouter un item dans l'inventaire
func insert(item: InvItem):
	# Ajouter un item en plus à l'item actuel
	for slot in slots:
		if slot.item == item and slot.amount < item.max_amount:
			slot.amount += 1
			update.emit()
			return true
	# Ajouter un item
	for slot in slots:
		if slot.is_empty_slot():
			slot.item = item
			slot.amount = 1
			update.emit()
			return true
	return false

func has_item(requested_item):
	for slot in slots:
		if slot.item == requested_item && slot.item != null:
			return true
	return false
	
func discard_item_from_slot(slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot():
		slot.discard_item()
		update.emit()

# transférer l'item du slot
func transfer_item(target_inv: Inv, slot: InvSlot) -> void:
	if slot and not slot.is_empty_slot() and target_inv:
		target_inv.insert(slot.item)
		slot.discard_item()
		update.emit()
		target_inv.update.emit()
		
func is_inv_full():
	for slot in slots:
		if slot.is_empty_slot():
			return false
	return true
	
