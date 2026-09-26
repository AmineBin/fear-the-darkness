extends Control

@onready var label: RichTextLabel = $RichTextLabel
@export var type_sfx: AudioStream
@onready var player = get_tree().get_first_node_in_group("player")
var is_displaying: bool = false

func _ready() -> void:
	var health_component = player.get_node_or_null("HealthComponent")
	health_component.hit.connect(_on_hit)
	
func show_text(new_text):
	if is_displaying:
		return
	
	is_displaying = true
	label.text = new_text
	label.visible_characters = 1
	
	for i in range(1, new_text.length() + 1):
			label.visible_characters = i
			
			if type_sfx and new_text[i - 1] != " ":
				SoundPlayer.audio_play(type_sfx)
			await get_tree().create_timer(0.05).timeout
	
	await get_tree().create_timer(3.0, false).timeout
	
	label.text = ""
	
	is_displaying = false

func _on_hit() -> void:
	$ColorRect.visible = true
	await get_tree().create_timer(0.2).timeout
	$ColorRect.visible = false

func show_text_interact():
	var key_name = OS.get_keycode_string(InputMap.action_get_events("interact")[0].physical_keycode)
	$InteractLabel.text = "Press [" + key_name + "] to interact"
