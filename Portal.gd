extends Area2D


var enteredTime = 0
var enteredDelay = 3.0
var entered = false

var minigame = 0
var alreadyEmittedSignal = false

var minigamescreen = null

var vaseminigamescene = preload("res://vase_minigame.tscn")
var mouseminigamescene = preload("res://mouse_minigame.tscn")
var parkourminigamescene = preload("res://parkour_minigame.tscn")

signal opened (index)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if minigamescreen != null:
		#get_parent().visible = false
		if minigame == 0 or minigame == 1:
			minigamescreen.global_position = get_parent().get_node("CatProtagonist").get_node("CatCamera").get_screen_center_position() + Vector2(-640, -360)
		elif minigame == 2:
			minigamescreen.global_position = get_parent().get_node("CatProtagonist").get_node("CatCamera").get_screen_center_position()
	else:
		#get_parent().visible = true
		pass
		
	if not entered:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("entered")
		enteredTime += delta
		if (enteredTime >= enteredDelay):
			Globalvariables.isLoading = true
			entered = false
			Globalvariables.inMinigame = true
			#TODO: instantiate minigame screen here depending on the value of minigame
			#Remember to change that variable to false after minigame exited!
			if minigame == 0: #vase minigame
				emit_signal("opened", 0)
				minigamescreen = vaseminigamescene.instantiate()
				minigamescreen.z_index = 1000
				Globalvariables.isLoading = false
				get_parent().add_child(minigamescreen)
				minigamescreen.set_visible(true)
				visible = false
			elif minigame == 1: #mouse minigame
				emit_signal("opened", 1)
				minigamescreen = mouseminigamescene.instantiate()
				minigamescreen.z_index = 1000
				Globalvariables.isLoading = false
				get_parent().add_child(minigamescreen)
				minigamescreen.set_visible(true)
				visible = false
			elif minigame == 2: #parkour minigame
				emit_signal("opened", 2)
				Globalvariables.maze = get_parent().maze
				Globalvariables.resume = true
				Globalvariables.fishkarma = get_parent().fishkarma
				Globalvariables.fishCoords = get_parent().fish_coords
				Globalvariables.characterPos = get_parent().get_node("CatProtagonist").global_position
				Globalvariables.setOfCoords = get_parent().setOfCoords
				Globalvariables.minigameindices = get_parent().minigameindices
				get_tree().change_scene_to_file("res://parkour_minigame.tscn")
						
			
	pass


func _on_body_entered(body):
	if body.is_in_group("protagonist") and visible:
		Globalvariables.inMinigame=true
		entered = true
		if not alreadyEmittedSignal:
			alreadyEmittedSignal = true
	pass # Replace with function body.
