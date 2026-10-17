extends Control

@onready var save_validate: Label = $PopUp/Label2
@onready var slot_buttons: Array[Button] = [
	$NinePatchRect/GridContainer/SlotButton1,
	$NinePatchRect/GridContainer/SlotButton2,
	$NinePatchRect/GridContainer/SlotButton3,
	$NinePatchRect/GridContainer/SlotButton4,
]
@onready var slot_labels: Array[Label] = [
	$NinePatchRect/GridContainer/SlotButton1/Label,
	$NinePatchRect/GridContainer/SlotButton2/Label,
	$NinePatchRect/GridContainer/SlotButton3/Label,
	$NinePatchRect/GridContainer/SlotButton4/Label,
]

var save_slot = 1

func _ready() -> void:
	for i in slot_buttons.size():
		var button = slot_buttons[i]
		button.pressed.connect(select_save_slot.bind(i + 1))
	update_slot()
	
func select_save_slot(i):
	save_slot = i
	print(save_slot)
	
func format_hour(value):
	var hours = int(value)
	var minutes = int((value - hours) * 60)
	var seconds = int((((value - hours) * 60) - minutes) * 60)
	value = "%02d:%02d:%02d" % [hours, minutes, seconds]
	return value

func _on_save_pressed() -> void:
	SaveManager.save_all(save_slot)
	#save_validate.show()
	#save_validate.text = "Data save complete, you can turn off your device safely."
	update_slot()

func _on_load_pressed() -> void:
	SaveManager.load_all(save_slot)

func _on_delete_pressed() -> void:
	SaveManager.delete(save_slot)
	update_slot()
	
func update_slot():
	for i in slot_buttons.size():
		var button = slot_buttons[i]
		var slot_nb = i + 1
		var path = SaveManager.get_save_path(slot_nb)
		
		if not FileAccess.file_exists(path):
			slot_labels[i].text = "empty"
		else:
			var loaded_data = ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_IGNORE)
			var play_time = format_hour(loaded_data.play_time)
			slot_labels[i].text = "slot" + str(slot_nb) + " - " + play_time
