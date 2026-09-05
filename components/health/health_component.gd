extends Node

class_name HealthComponent

@export var health = 4
@export var max_health = 4

signal died
signal health_changed

func take_damage(amount):
	health = clamp(health - amount, 0, max_health) 
	health_changed.emit(health)
	if health <= 0:
		died.emit()
		
func regain_health(amount):
	health = clamp(health + amount, 0, max_health) 
	health_changed.emit(health)

func can_be_healed() -> bool:
	if health > 0 and health < max_health:
		return true
	else:
		return false
