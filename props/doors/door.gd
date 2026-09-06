extends Node3D

class_name Door

var toggle = false
var interactable = true
@export var key: InvItem
@export var key_needed = false
@export var animation_player: AnimationPlayer

func interact(user:Node = null):
	var target_user = user if user else get_tree().get_first_node_in_group("player")
	
	if key_needed and target_user and not target_user.inv.has_item(key):
		if target_user and target_user.has_method("display_message"):
			target_user.display_message("I need a key for this one.")
		return
	
	# Déverrouiller la porte
	if target_user and target_user.inv.has_item(key):
		if key_needed == true:
			$UnlockSFX.play()
			key_needed = false
	
	if interactable == true:
		interactable = false
		toggle = !toggle
	
	if toggle == false:
		animation_player.play("close")
	else:
		animation_player.play("open")
		
	await get_tree().create_timer(1.0, false).timeout
	
	interactable = true
