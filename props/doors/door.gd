extends Node3D

class_name Door

var interactable = true

@export var key: InvItem

@export var is_open: bool = false
@export var key_needed = false
@export var is_door_handle_needed: bool
@export var is_door_no_open: bool

@export var animation_player: AnimationPlayer

var door_handle: MeshInstance3D 

func _ready() -> void:
	door_handle = get_node_or_null("hinge/DoorHandle/DoorHandle")
	
	if door_handle:
		if is_door_handle_needed == true:
			door_handle.visible = false
		else: 
			door_handle.visible = true

func interact(user:Node = null):
	if key_needed and user and not user.inv.has_item(key):
		if user and user.has_method("display_message"):
			user.display_message("I need a key for this one.")
		return
	
	if is_door_handle_needed and user and not user.inv.has_item(key):
		if user and user.has_method("display_message"):
			user.display_message("I need to find a handle for this door.")
		return
		
	if is_door_no_open and user and not user.inv.has_item(key):
		if user and user.has_method("display_message"):
			user.display_message("There is something behind this door.")
		return
	
	if door_handle:
		door_handle.visible = true
		
	unlock_door()
	
	if interactable == true:
		interactable = false
		is_open = !is_open
	
	update_visual()
		
	await get_tree().create_timer(1.0, false).timeout
	
	interactable = true

func unlock_door(user:Node = null):
	var target_user = user if user else get_tree().get_first_node_in_group("player")
	if target_user and target_user.inv.has_item(key):
		if key_needed == true:
			$UnlockSFX.play()
			key_needed = false
			
func update_visual():
	if is_open == false && animation_player:
			animation_player.play("close")
	elif is_open == true && animation_player:
		animation_player.play("open")
	
