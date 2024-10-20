extends Area2D


var moveSpeed = 300
signal ateMouse
var detectionRange = 600
var enticingSpeed = 225
var radius = 300
var isMovingRight = true
var screen_center = Vector2(640, 360)
var lastPos: Vector2
var contactRange = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("move_left"):
		position.x -= moveSpeed*delta
	if Input.is_action_pressed("move_right"):
		position.x += moveSpeed*delta
	if Input.is_action_pressed("move_up"):
		position.y -= moveSpeed*delta
	if Input.is_action_pressed("move_down"):
		position.y += moveSpeed*delta
	
	var closerangemice = []
	for node in get_parent().get_children():
		if node.is_in_group("mice") and node != null:
			if (node.position.distance_to(position) <= detectionRange):
				closerangemice.append(node)
	
	var closestmouse = null
	var closestdistance = 9999999
	
	for mouse in closerangemice:
		if (mouse.position.distance_to(position) < closestdistance):
			closestdistance = mouse.position.distance_to(position) 
			closestmouse = mouse
	
	if closestmouse != null:
		#this should work!
		var difference = position - closestmouse.position
		var angle = PI + difference.normalized().angle()
		
		if difference.length() > contactRange: #stops cat from spazzing
			position += enticingSpeed * delta * Vector2(cos(angle), sin(angle))
				
	
	

	position.x = clamp(position.x, screen_center.x - sqrt(max(0, radius*radius - (screen_center.y - position.y)*(screen_center.y - position.y))),  screen_center.x + sqrt(max(0, radius*radius - (screen_center.y - position.y)*(screen_center.y - position.y))))
	position.y = clamp(position.y, screen_center.y - radius, screen_center.y + radius)
	
	#position.x = clamp(position.x, 0, 1280)
	#position.y = clamp(position.y, 0, 720)
	
	if position.x - lastPos.x > 0:
		$AnimatedSprite2D.play("enticed")
		isMovingRight = true
	elif position.x - lastPos.x < 0:
		$AnimatedSprite2D.play("enticed")
		isMovingRight = false
	else:
		$AnimatedSprite2D.frame = 1
		$AnimatedSprite2D.stop()
		
		
	$AnimatedSprite2D.flip_h = not isMovingRight
	
	lastPos = position
	pass
	



func _on_area_entered(area):
	if area.is_in_group("mice"):
		emit_signal("ateMouse")
	pass # Replace with function body.
