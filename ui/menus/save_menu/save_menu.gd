class_name SaveGame
extends Resource

@export var player_inventory: Inv
@export var chest_inventory: Inv
@export var player_health: int

static func get_save_path(slot: int) -> String:
	return "user://savegame_%d.tres" %slot 

func write_savegame(slot: int) -> void:
	ResourceSaver.save(self, get_save_path(slot))
	
static func load_savegame(slot: int) -> Resource:
	var path = get_save_path(slot)
	if ResourceLoader.exists(path):
		return load(path)
	return null
