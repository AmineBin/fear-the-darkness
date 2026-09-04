extends Area3D

@export var item: InvItem
@onready var player = get_node("/root/Playground/Player") 

func interact():
	player.collect(item)
	self.queue_free()
