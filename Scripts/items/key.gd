extends Area3D

@export var item: InvItem

func interact():
	var player = get_node("/root/Main/Player")
	player.collect(item)
	self.queue_free()
