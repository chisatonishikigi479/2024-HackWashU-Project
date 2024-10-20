extends CharacterBody2D

signal died
const SPEED = 400.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var isDead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var diedTime = 0.0
var diedTimeDelay = 3.0
var alreadySignalled = false
var ducking = false


func _physics_process(delta):

	# Add the gravity.
	
	
	if not isDead and (not get_parent().completed):
		print("global position of cat: " + str(global_position))
		if not is_on_floor():
			# play jump animation!
			velocity.y += gravity * delta
			$AnimatedSprite2D.play("default")
		else:
			#play walk/run animation!
			pass

		# Handle jump.
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY


		if Input.is_action_pressed("move_down") and is_on_floor():
			$CollisionShape2D.position.y = 40
			$CollisionShape2D.scale.y = 0.25
			ducking = true
			$AnimatedSprite2D.play("ducking")
		else:
			$CollisionShape2D.position.y = 0
			$CollisionShape2D.scale.y = 1
			ducking = false
			
		velocity.x = SPEED
		
		for i in range(get_slide_collision_count()):
			var collider = get_slide_collision(i).get_collider()
			if collider.is_in_group("platforms") and position.y >= collider.position.y - 50:
				isDead = true
			
		move_and_slide()
	else:
		#play death animation!
		if not alreadySignalled:
			print("died at " + str(position.x))
			emit_signal("died")
			Globalvariables.karma -= 5
			alreadySignalled = true
		diedTime += delta
		if diedTime >= diedTimeDelay:
			Globalvariables.inMinigame = false
			get_tree().change_scene_to_file("res://maze_generation_manager.tscn")



		
