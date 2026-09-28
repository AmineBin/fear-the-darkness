extends Resource
class_name SaveDataResource

@export var health = 0
@export var position = Vector3(0,0,0)
@export var door_states: Dictionary = {}
@export var play_time: float = 0.0
@export var player_inventory: Inv = Inv.new()
@export var chest_inventory: Inv = Inv.new(24)
@export var picked_up_items: Array[String] = []
