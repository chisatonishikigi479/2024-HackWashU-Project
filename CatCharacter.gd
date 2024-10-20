extends CharacterBody2D

signal died
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var isDead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var diedTime = 0.0
var diedTimeDelay = 3.0
var alreadySignalled = false

func _physics_process(delta):
	# Add the gravity.
	if not isDead:
		if not is_on_floor():
			# play jump animation!
			velocity.y += gravity * delta
			
		else:
			#play walk/run animation!
			pass
		
		$AnimatedSprite2D.play("default") #filler animation code

		# Handle jump.
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		velocity.x = SPEED
		move_and_slide()
	else:
		#play death animation!
		if not alreadySignalled:
			emit_signal("died")
			Globalvariables.karma -= 5
			alreadySignalled = true
		diedTime += delta
		if diedTime >= diedTimeDelay:
			#queue_free()
			#get_parent().queue_free()
			get_tree().reload_current_scene()
			Globalvariables.inMinigame = false


		
