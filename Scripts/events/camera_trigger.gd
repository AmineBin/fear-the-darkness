extends Area3D

var in_trigger = false

func enter_trigger(body):
	if body.name == "Player":
		in_trigger = true
		print("enter trigger")
		
func exit_trigger(body):
	if body.name == "Player":
		in_trigger = false
		print("exit trigger")
	
func _process(_delta: float) -> void:
	if in_trigger && get_parent().current != true:
		get_parent().current = true
