extends Entity

class_name Player

const sensitivity = 0.002

const bob_freq = 2.0
const bob_amp = 0.08
var t_bob = 0.0

const base_fov = 75.0
const fov_change = 1.5

var is_holding_object = false
var held_object = null

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var seecast = $Head/Camera3D/SeeCast

@export var inv: Inv

signal player_hit(current_health: int)

func _ready() -> void:
	walk_speed = 2.0
	sprint_speed = 3.5
	health = 4
	jump_velocity = 3
	gravity = 9.8
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(70))

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = walk_speed
		
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction: 
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 10.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint_speed * 2)
	var target_fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	# Si le joueur est à porté d'un prop il peut intéragir avec
	if seecast.is_colliding():
		var target = seecast.get_collider()
		if Input.is_action_just_pressed("interact"):
			if target.is_in_group("Door"):
				target.get_owner().interact()
			else:
				target.interact()
	
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq/2) * bob_amp
	return pos
	
# Mettre un item dans l'inventaire du joueur
func collect(item):
	inv.insert(item)
	
func take_damage(amount):
	super.take_damage(amount)
	player_hit.emit(health)

func regain_health(amount):
	var health_node = get_node("/root/Playground/Inventory/Inv_UI/VBoxContainer/Health")
	health = clamp(health + amount, 0, 4) 
	health_node.update_display(health)
