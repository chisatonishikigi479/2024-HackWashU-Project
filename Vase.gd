extends Node2D


signal vase_broken
var isBroken = false
var succeeded = false
var brokenTime = 0.0
var brokenTimeDelay = 3.0
var velocity = 0.0
var rotationAcceleration = 45.0
var correctingVelocity = 180.0
var leftBound = 125.0
var fallingVelocity = 0.0
var fallingLeftVelocity = 325.0
var gravity = 250.0
var fellOff = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	succeeded = get_parent().succeeded
	if isBroken:
		emit_signal("vase_broken")
		$AnimatedSprite2D.play("break")
		brokenTime += delta
		if brokenTime >= brokenTimeDelay:
			queue_free()
			get_parent().queue_free()
	else:
		$AnimatedSprite2D.play("default")
		if not succeeded:
			
			if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
				if (int(rotation_degrees + 360) % 360 >= 120) or (int(rotation_degrees + 360) % 360 <= 3):
					velocity = 0
				
			if (not Input.is_action_pressed("move_right")) and (not Input.is_action_pressed("move_left")):
				if not fellOff:
					if int(rotation_degrees + 360) % 360 >= 270 or int(rotation_degrees + 360) % 360 <= 3:
						velocity += rotationAcceleration * delta
						rotation_degrees -= velocity * delta
					elif int(rotation_degrees + 360) % 360 <= 150 and int(rotation_degrees + 360) % 360 > 3:
						velocity += rotationAcceleration * delta
						rotation_degrees += velocity * delta
					
				
			else: 
				print("input pressed")
				if Input.is_action_pressed("move_right"):
					velocity = correctingVelocity
					rotation_degrees += velocity * delta
				elif Input.is_action_pressed("move_left"):
					velocity = correctingVelocity
					rotation_degrees -= velocity * delta
				
			if (int(rotation_degrees + 360) % 360 <= 320 and int(rotation_degrees + 360) % 360 >= 250):
				fellOff = true
				
			if (int(rotation_degrees + 360) % 360 >= 90 and int(rotation_degrees + 360) % 360 <= 150):
				isBroken = true
				
			if fellOff:

				position.x -= fallingLeftVelocity * delta
				fallingVelocity += gravity * delta
				position.y += fallingVelocity
				rotation_degrees -= fallingVelocity * delta
				
				
				
			pass
		
		
		position.x = clamp(position.x, leftBound, 2024)
	pass


func _on_area_entered(area):
	if area.is_in_group("ground"):
		isBroken = true
	pass # Replace with function body.
