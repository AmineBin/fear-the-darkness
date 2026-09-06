extends Control

@onready var label: RichTextLabel = $RichTextLabel
@export var type_sfx: AudioStream
var is_displaying: bool = false

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
