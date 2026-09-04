extends Control

@onready var player_gui_dialog_node = get_node("/root/Playground/GUI/PlayerGUI/RichTextLabel")

func show_text(new_text):
	if player_gui_dialog_node.text != "":
		return
	else:
		$RichTextLabel.text = new_text
		$RichTextLabel.visible_characters = 1
		for i in range(new_text.length()+1):
				$RichTextLabel.visible_characters = i
				await get_tree().create_timer(0.05).timeout
				SoundPlayer.audio_play(preload("res://sfx/ui/menu/click.wav"))
		await get_tree().create_timer(3.0, false).timeout
		player_gui_dialog_node.text = ""
