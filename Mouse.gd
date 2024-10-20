extends Area2D

signal died
var deathTime = 0.0
var deathDelay = 0.5
var isDead = false

var angle = PI/3 #in radians

var orig_distance = 900
var orig_pos: Vector2
var target_pos: Vector2
var radius = 300
var moveSpeed = 300
var timeElapsedToTarget = 0.0
var goingToTarget = true
var atTarget = false
var timeElapsedAtTarget = 0.0
var timeLimitAtTarget = 2.0
var exitingTarget = false
var timeElapsedExitingTarget = 0.0
var timeLimitExitingTarget = 2.5
var skinType = str(randi_range(0, 2)) 

var screen_center = Vector2(640, 360)

# Called when the node enters the scene tree for the first time.
func _ready():
	orig_pos = screen_center + orig_distance*Vector2(cos(angle), sin(angle))
	position = orig_pos
	target_pos = screen_center + radius*Vector2(cos(angle), sin(angle))
	$AnimatedSprite2D.play("skin" + skinType) #Random skin for the mouse
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDead:
		$AnimatedSprite2D.play("death" + skinType)
		deathTime += delta
		if deathTime >= deathDelay: 
			emit_signal("died")
			queue_free()
			
		
	else:
		$AnimatedSprite2D.play("skin" + skinType)
		if goingToTarget:
			if cos(angle) <= 0: #makes the mouse turn the correct way
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			position += -moveSpeed * delta * Vector2(cos(angle), sin(angle))
			print("position: " + str(position))
			timeElapsedToTarget += delta
			if timeElapsedToTarget >= (orig_distance - radius) / moveSpeed:
				goingToTarget = false
				atTarget = true
		
		if atTarget:
			timeElapsedAtTarget += delta
			if timeElapsedAtTarget >= timeLimitAtTarget:
				atTarget = false
				exitingTarget = true
				
			
			
		if exitingTarget:
			if cos(angle) >= 0: #makes the mouse turn the correct way
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			position += moveSpeed * delta * Vector2(cos(angle), sin(angle))
			print("position: " + str(position))
			timeElapsedExitingTarget += delta
			if timeElapsedExitingTarget >= timeLimitExitingTarget:
				queue_free()
		
		

	pass




func _on_area_entered(area):
	if area.is_in_group("cat"):
		isDead = true
	pass # Replace with function body.
