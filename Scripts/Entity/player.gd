extends CharacterBody3D

const speed = 4.0
const rotation_speed = 3.0
const gravity = 9.8

func _physics_process(delta):
	# si le perso ne touche pas le sol on le fait tomber
	if not is_on_floor():
		velocity.y -= gravity * delta

	# faire tourner le perso sur lui même
	if Input.is_action_pressed("ui_left"):
		rotate_y(rotation_speed * delta)

	if Input.is_action_pressed("ui_right"):
		rotate_y(-rotation_speed * delta)

	# la direction actuelle du perso
	var direction = Vector3.ZERO
	
	# faire avancer le perso
	if Input.is_action_pressed("ui_up"):
		direction = transform.basis.z * speed

	# faire reculer le perso
	if Input.is_action_pressed("ui_down"):
		direction = -transform.basis.z * speed
	
	
	velocity.x = direction.x
	velocity.z = direction.z
	
	move_and_slide()
