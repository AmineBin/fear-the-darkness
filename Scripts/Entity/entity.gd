extends CharacterBody3D

class_name Entity

var speed
var walk_speed = 2.0
var sprint_speed = 3.5
var health = 4
var jump_velocity = 3
var gravity = 9.8

func take_damage(amount):
	health -= amount
	if health == 0:
		die()
		
func die():
	self.queue_free()

func deal_damage(target, damage):
	target.health -= damage
