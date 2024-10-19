extends Area2D


var enteredTime = 0
var enteredDelay = 3.0
var entered = false

var minigame = 0
var alreadyEmittedSignal = false

var minigamescreen = null

var vaseminigamescene = preload("res://vase_minigame.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if minigamescreen != null:
		minigamescreen.global_position = get_parent().get_node("CatProtagonist").get_node("CatCamera").get_screen_center_position() + Vector2(-500, -300)
	
	if not entered:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("entered")
		enteredTime += delta
		if (enteredTime >= enteredDelay):
			entered = false
			Globalvariables.inMinigame = true
			#TODO: instantiate minigame screen here depending on the value of minigame
			#Remember to change that variable to false after minigame exited!
			if minigame == 0:
				minigamescreen = vaseminigamescene.instantiate()
				get_parent().add_child(minigamescreen)
				minigamescreen.z_index = 4050
				minigamescreen.set_visible(true)
			elif minigame == 1:
				#change this later to minigame 1
				minigamescreen = vaseminigamescene.instantiate()
				get_parent().add_child(minigamescreen)
				minigamescreen.z_index = 4050
				minigamescreen.set_visible(true)
				pass
			elif minigame == 2:
				#change this later to minigame 2
				minigamescreen = vaseminigamescene.instantiate()
				get_parent().add_child(minigamescreen)
				minigamescreen.z_index = 4050
				minigamescreen.set_visible(true)
				pass
			visible = false
	pass


func _on_body_entered(body):
	if body.is_in_group("protagonist") and visible:
		entered = true
		if not alreadyEmittedSignal:
			alreadyEmittedSignal = true
	pass # Replace with function body.
