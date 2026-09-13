extends Node

const save_location = "user://fear_the_darkness/savegame.tres"
var save_file_data: SaveDataResource = SaveDataResource.new()
var game_scene_path = "res://playground.tscn"

@export var player_inventory: Resource
	
func _save():
	DirAccess.make_dir_recursive_absolute("user://fear_the_darkness")
	var err = ResourceSaver.save(save_file_data, save_location)

func save_player() -> void:
	var player = get_tree().get_first_node_in_group("player")
	var health_component = player.get_node_or_null("HealthComponent")
	save_file_data.health = health_component.health
	save_file_data.position = player.global_position
	save_file_data.play_time = PlayTimeTracker.play_time

func save_doors() -> void:
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		save_file_data.door_states[str(door.get_path())] = {
			"locked": door.key_needed,
			"open": door.is_open
		}

func save_inventories() -> void:
	var player = get_tree().get_first_node_in_group("player")
	var chest_ui = get_tree().get_first_node_in_group("chest_inv_ui")
	
	var player_inventory = player.inv
	var chest_inventory = chest_ui.chest_inv
	
	var new_player_inventory = Inv.new()
	var new_chest_inventory = Inv.new()
	
	for slot in player_inventory.slots:
		var new_slot = InvSlot.new()
		new_slot.amount = slot.amount
		new_slot.item = slot.item
		new_player_inventory.slots.append(new_slot)
	
	for slot in chest_inventory.slots:
		var new_slot = InvSlot.new()
		new_slot.amount = slot.amount
		new_slot.item = slot.item
		new_chest_inventory.slots.append(new_slot)
	
	save_file_data.player_inventory = new_player_inventory
	save_file_data.chest_inventory = new_chest_inventory
	
func save_all():
	save_player()
	save_doors()
	save_inventories()
	_save()
		
func _load():
	if FileAccess.file_exists(save_location):
		save_file_data = ResourceLoader.load(save_location).duplicate(true)

func load_player():
	var player = get_tree().get_first_node_in_group("player")
	var health_component = player.get_node_or_null("HealthComponent")
	health_component.health = save_file_data.health
	player.global_position = save_file_data.position
	PlayTimeTracker.play_time = save_file_data.play_time
	
func load_doors() -> void:
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		if save_file_data.door_states.has(str(door.get_path())): # Vérifie que la porte a un door_state
			var door_data = save_file_data.door_states[str(door.get_path())]
			door.key_needed = door_data["locked"]
			door.is_open = door_data["open"]
			door.update_visual()

func load_inventories():
	var player = get_tree().get_first_node_in_group("player")
	var player_inv_ui = get_tree().get_first_node_in_group("player_inv")
	var chest_ui = get_tree().get_first_node_in_group("chest_inv_ui")
	
	player.inv = save_file_data.player_inventory
	chest_ui.chest_inv = save_file_data.chest_inventory
	
	player_inv_ui.inv = save_file_data.player_inventory
	chest_ui.chest_inv = save_file_data.chest_inventory
	
	player_inv_ui.set_inventory(save_file_data.player_inventory)
	chest_ui.set_inventory(save_file_data.chest_inventory, save_file_data.player_inventory)

func load_all():
	_load()
	if get_tree().current_scene.scene_file_path != game_scene_path:
		get_tree().change_scene_to_file(game_scene_path)
		await get_tree().scene_changed
	load_player()
	load_doors()
	load_inventories()
