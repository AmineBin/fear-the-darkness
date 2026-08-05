extends Resource

class_name InvSlot

@export var item: InvItem
@export var amount: int

func discard_item():
	if self.amount > 0:
		self.amount = self.amount - 1
	if self.amount == 0:
		self.item = null
