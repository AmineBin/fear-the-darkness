extends Node3D

class_name Door

var toggle = false
var interactable = true
@export var key_needed = false
@export var key: InvItem
@export var animation_player: AnimationPlayer

@onready var player_node = get_node("/root/Playground/Player")
@onready var player_gui_node = get_node("/root/Playground/Player/GUI/PlayerGUI")
@onready var player_gui_dialog_node = get_node("/root/Playground/Player/GUI/PlayerGUI/RichTextLabel")

func interact():
	if key_needed && !player_node.inv.has_item(key):
		player_gui_node.show_text("I need a key for this one.")
		await get_tree().create_timer(3.0, false).timeout
		player_gui_dialog_node.text = ""
		return
		
	if key_needed && player_node.inv.has_item(key):
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
	
	
