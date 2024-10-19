extends Area2D


var enteredTime = 0
var enteredDelay = 3.0
var entered = false

var minigame = 0
var alreadyEmittedSignal = false

var minigamescreen = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if minigamescreen != null:
		minigamescreen.global_position = get_parent().get_node("CatProtagonist").get_node("CatCamera").get_screen_center_position()
	
	if not entered:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("entered")
		enteredTime += delta
		if (enteredTime >= enteredDelay):
			entered = false
			#TODO: instantiate minigame screen here depending on the value of minigame
			
			visible = false
	pass


func _on_body_entered(body):
	if body.is_in_group("protagonist") and visible:
		entered = true
		if not alreadyEmittedSignal:
			alreadyEmittedSignal = true
	pass # Replace with function body.
