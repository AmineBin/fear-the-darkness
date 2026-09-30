extends Node3D

class_name Door

var interactable = true

@export var is_open = false
@export var key: InvItem
@export var key_needed = false
@export var animation_player: AnimationPlayer

func _ready() -> void:
	pass
	#update_visual()

func interact(user:Node = null):
	var target_user = user if user else get_tree().get_first_node_in_group("player")
	
	if key_needed and target_user and not target_user.inv.has_item(key):
		if target_user and target_user.has_method("display_message"):
			target_user.display_message("I need a key for this one.")
		return
		
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
	if is_open == false:
		animation_player.play("close")
	else:
		animation_player.play("open")
	
