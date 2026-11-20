extends Control

@export var pause_menu: Control
@export var click_sfx: AudioStream
@export_file("*.tscn") var main_menu_scene_path: String
@export var input_button_scene: PackedScene
@export var action_list: VBoxContainer 

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"move_forward": "Move forward",
	"move_left": "Move left",
	"move_right": "Move right",
	"move_back": "Move back",
	"interact": "Interact",
	"toggle_inventory": "Toggle inventory",
	"sprint": "Sprint",
	"toggle_flashlight": "Toggle flashlight"
}

func _ready():
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" - Physical")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Waiting fo input..."

func _input(event):
	if is_remapping:
		if(event is InputEventKey || event is InputEventMouseButton && event.pressed):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null

func _on_reset_controls_pressed() -> void:
	_create_action_list()
	
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" - Physical")
	
func _on_back_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	if get_tree().paused && pause_menu.visible:
		hide()
	else:
		get_tree().change_scene_to_file(main_menu_scene_path)
		
func _on_save_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
