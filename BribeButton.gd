extends Area2D

var hasMouse = false
signal bribed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasMouse:
		if Input.is_action_just_pressed("click") and visible:
			emit_signal("bribed")
			
	pass


func _on_mouse_entered():
	hasMouse = true
	pass # Replace with function body.


func _on_mouse_exited():
	hasMouse = false
	pass # Replace with function body.
