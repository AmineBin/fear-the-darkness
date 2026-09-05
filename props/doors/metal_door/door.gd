extends Node3D

class_name Door

var toggle = false
var interactable = true
@export var key_needed = false
@export var key: InvItem
@export var animation_player: AnimationPlayer

@export var player: CharacterBody3D
@export var player_gui: Control
@export var player_gui_dialog: Control

func interact():
	if key_needed && !player.inv.has_item(key):
		player_gui.show_text("I need a key for this one.")
		return
		
	if key_needed && player.inv.has_item(key):
		$UnlockSFX.play()
		key_needed = false
		
	if interactable == true:
		interactable = false
		toggle = !toggle
	if toggle == false:
		animation_player.play("close")
	if toggle == true:
		animation_player.play("open")
	await get_tree().create_timer(1.0, false).timeout
	interactable = true
	
	
