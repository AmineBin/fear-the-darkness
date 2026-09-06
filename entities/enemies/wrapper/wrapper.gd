extends CharacterBody3D

class_name Wrapper

var speed
var walk_speed = 2.0
var sprint_speed = 3.5
var health = 4
var jump_velocity = 3
var gravity = 9.8

const detection_range = 10.0
const attack_trigger_range = 2.0
const attack_register_range = 3.5
var can_attack = true
var attack_cooldown = 1.0
var state_machine
@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree
var player: CharacterBody3D

func _ready() -> void:
	speed = walk_speed
	player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if not player:
		push_error("player not found")
	state_machine = anim_tree.get("parameters/playback")
	
func _process(delta):
	
	# Gravité
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		"Run":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * speed
			look_at(Vector3(player.global_position.x + velocity.x, global_position.y, player.global_position.z + velocity.z), Vector3.UP)
		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	# Conditions
	anim_tree.set("parameters/conditions/idle", !_target_in_detection_range())
	anim_tree.set("parameters/conditions/attack", _target_in_attack_range() && can_attack)
	anim_tree.set("parameters/conditions/run", _target_in_detection_range() && can_attack)
	
	anim_tree.get("parameters/playback")
	
	move_and_slide()

func _target_in_detection_range():
	if global_position.distance_to(player.global_position) < detection_range:
		return true
	else:
		return false

func _target_in_attack_range():
	return global_position.distance_to(player.global_position) < attack_trigger_range
	
func hit_finished():
	if !can_attack:
		return
	if global_position.distance_to(player.global_position) < attack_register_range:
		can_attack = false
		player.take_damage(1)
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
		
func deal_damage(target, damage):
	target.health -= damage
