extends Area2D

var isHappy
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isHappy:
		$AnimatedSprite2D.play("angry")
	else:
		$AnimatedSprite2D.play("happy")
	pass
