extends Node2D


var completed = false
var completedTime = 0.0
var completedTimeDelay = 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if completed:
		
		completedTime += delta
		if completedTime >= completedTimeDelay:
			queue_free()
		pass
	
	pass
