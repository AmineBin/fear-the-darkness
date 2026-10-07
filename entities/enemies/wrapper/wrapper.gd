extends CharacterBody3D

class_name Wrapper

var speed: float
var walk_speed: float = 2.0
var gravity: float = 9.8
var damage: int = 1

const detection_range = 10.0
const attack_trigger_range = 2.0
const attack_register_range = 3.5

var can_attack: bool = true
var attack_cooldown: float = 1.0
var state_machine: AnimationNodeStateMachinePlayback

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D

signal target_hit

func _ready() -> void:
	speed = walk_speed
	player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	state_machine = anim_tree.get("parameters/playback")
	
func _physics_process(delta: float) -> void:
	if not is_instance_valid(player) or not player.is_inside_tree():
		player = get_tree().get_first_node_in_group("player") as CharacterBody3D

	if not player:
		velocity.x = 0.0
		velocity.z = 0.0
		anim_tree.set("parameters/conditions/idle", true)
		anim_tree.set("parameters/conditions/attack", false)
		anim_tree.set("parameters/conditions/run", false)
		move_and_slide()
		return
	
	# Gravité
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	
	velocity.x = 0.0
	velocity.z = 0.0
	
	match state_machine.get_current_node():
		"Run":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			var direction = (next_nav_point - global_position).normalized()
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			_look_at_player(Vector3(player.global_position.x + velocity.x, global_position.y, player.global_position.z + velocity.z))
		"Attack":
			_look_at_player(Vector3(player.global_position.x, global_position.y, player.global_position.z))
	
	# Conditions
	var in_detection_range := _target_in_detection_range()
	var in_attack_range := _target_in_attack_range()
	anim_tree.set("parameters/conditions/idle", not in_detection_range)
	anim_tree.set("parameters/conditions/attack", in_attack_range and can_attack)
	anim_tree.set("parameters/conditions/run", in_detection_range and can_attack)
	
	move_and_slide()

func _target_in_detection_range() -> bool:
	return is_instance_valid(player) and global_position.distance_to(player.global_position) < detection_range

func _target_in_attack_range() -> bool:
	return is_instance_valid(player) and global_position.distance_to(player.global_position) < attack_trigger_range

func _look_at_player(target_position: Vector3) -> void:
	if global_position.distance_squared_to(target_position) > 0.001:
		look_at(target_position, Vector3.UP)
	
func hit_finished() -> void:
	if not can_attack or not is_instance_valid(player):
		return
	if global_position.distance_to(player.global_position) < attack_register_range:
		can_attack = false
		var player_health_component = player.get_node_or_null("HealthComponent") as HealthComponent
		deal_damage(player_health_component, damage)
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
		

func deal_damage(target: HealthComponent, damage_amount: int) -> void:
	if not is_instance_valid(target):
		return
	target.take_damage(damage_amount)
	target_hit.emit()
