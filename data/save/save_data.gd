extends Resource
class_name SaveDataResource

@export var health = 0
@export var position = Vector3(0,0,0)
@export var door_states: Dictionary = {}
@export var play_time: float = 0.0
@export var player_inventory: Resource
@export var chest_inventory: Resource
@export var picked_up_items: Array[String] = []
