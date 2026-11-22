extends Control

@export var pause_menu: Control
@export var click_sfx: AudioStream
@export_file("*.tscn") var main_menu_scene_path: String
@export var input_button_scene: PackedScene
@export var action_list: VBoxContainer 

@export var audio_tab: VBoxContainer
@export var control_tab: VBoxContainer
@export var graphics_tab: VBoxContainer

@export var audio_button: Button
@export var control_button: Button
@export var graphics_button: Button

@onready var resolution_button: OptionButton = $ButtonManager/Graphics/Resolution
@onready var display_mode_button: OptionButton = $ButtonManager/Graphics/DisplayMode

var is_remapping = false
var action_to_remap = null
var remapping_button = null

# Liste des résolutions
const DISPLAY_RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1280, 720),
]

# Liste des touches du jeu
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
	graphics_button.toggle_mode = true
	_sync_display_settings()

# Syncroniser le display mode et la résultion actuelle avec l'affichage des inputs
func _sync_display_settings() -> void:
	var is_fullscreen := DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	display_mode_button.select(0 if is_fullscreen else 1)
	resolution_button.disabled = is_fullscreen

	if not is_fullscreen:
		var current_size := DisplayServer.window_get_size()
		for i in DISPLAY_RESOLUTIONS.size():
			if DISPLAY_RESOLUTIONS[i] == current_size:
				resolution_button.select(i)
				break

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
		
func _on_controls_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	audio_tab.hide()
	graphics_tab.hide()
	control_tab.show()
	audio_button.button_pressed = false
	graphics_button.button_pressed = false

func _on_audio_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	audio_tab.show()
	graphics_tab.hide()
	control_tab.hide()
	graphics_button.button_pressed = false
	control_button.button_pressed = false

func _on_graphics_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	audio_tab.hide()
	graphics_tab.show()
	control_tab.hide()
	audio_button.button_pressed = false
	control_button.button_pressed = false

func _on_save_pressed() -> void:
	SoundPlayer.audio_play(click_sfx)
	# TODO

# Changer la résolution
func _on_option_button_item_selected(index: int) -> void:
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		return

	DisplayServer.window_set_size(DISPLAY_RESOLUTIONS[index])

# Changer le display mode
func _on_display_mode_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			resolution_button.disabled = true
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			resolution_button.disabled = false
			_on_option_button_item_selected(resolution_button.selected) # Applique la résolution séléctionné
