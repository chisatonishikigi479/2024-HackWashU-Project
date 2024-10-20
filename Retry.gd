extends Area2D

var hasMouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasMouse:
		if Input.is_action_just_pressed("click"):
			Globalvariables.resume = false
			Globalvariables.fishkarma = 0
			Globalvariables.karma = 0
			get_tree().change_scene_to_file("res://maze_generation_manager.tscn")
			
	pass


func _on_mouse_entered():
	hasMouse = true
	pass # Replace with function body.


func _on_mouse_exited():
	hasMouse = false
	pass # Replace with function body.
