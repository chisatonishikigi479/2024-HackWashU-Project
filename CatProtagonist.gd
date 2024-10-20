extends CharacterBody2D


const speed = 400

var isMovingRight = true
var idleTime = 0
var stopWalkingTime = 0.3
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not Globalvariables.inMinigame:
		var velocity := Vector2.ZERO

		if Input.is_action_pressed("move_left"):
			if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
				velocity.x -= speed/1.4
			else:
				velocity.x -= speed
		if Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
				velocity.x += speed/1.4
			else:
				velocity.x += speed

		if Input.is_action_pressed("move_up"):
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				velocity.y -= speed/1.4
			else:
				velocity.y -= speed
		if Input.is_action_pressed("move_down"):
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				velocity.y += speed/1.4
			else:
				velocity.y += speed

		if (velocity.length() > 0):
			$AnimatedSprite2D.play("walk")
			idleTime = 0
		else:
			idleTime += delta
			if idleTime >  stopWalkingTime: #doesn't stop immediately
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.set_frame_and_progress(3,0)
		
		$AnimatedSprite2D.flip_h = !isMovingRight
		
		if velocity.x > 0:
			isMovingRight = true
		elif velocity.x < 0:
			isMovingRight = false
			
		
		self.velocity = velocity
		move_and_slide()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.set_frame_and_progress(3,0)
