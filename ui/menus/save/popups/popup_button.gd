extends Button

@onready var label: Label = $NinePatchRect/Label
@export var label_text: String = ""

func _ready() -> void:
	if label:
		label.text = label_text
