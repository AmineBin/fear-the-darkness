extends Control

@export var player_gui_dialog: Control
@export var click_sfx: AudioStream

func show_text(new_text):
	if player_gui_dialog.text != "":
		return
	else:
		$RichTextLabel.text = new_text
		$RichTextLabel.visible_characters = 1
		for i in range(new_text.length()+1):
				$RichTextLabel.visible_characters = i
				await get_tree().create_timer(0.05).timeout
				SoundPlayer.audio_play(click_sfx)
		await get_tree().create_timer(3.0, false).timeout
		player_gui_dialog.text = ""
