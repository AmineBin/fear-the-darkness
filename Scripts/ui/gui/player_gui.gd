extends Control


func show_text(new_text):
	$RichTextLabel.text = new_text
	$RichTextLabel.visible_characters = 1
	for i in range(new_text.length()+1):
			$RichTextLabel.visible_characters = i
			await get_tree().create_timer(0.05).timeout
