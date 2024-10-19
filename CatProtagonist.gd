extends CharacterBody2D


const speed = 400

var isMovingRight = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	var velocity := Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed

	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed

	if (velocity.length() > 0):
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.stop()
	
	$AnimatedSprite2D.flip_h = isMovingRight
	
	if velocity.x > 0:
		isMovingRight = true
	elif velocity.x < 0:
		isMovingRight = false
		
	
	self.velocity = velocity
	move_and_slide()
