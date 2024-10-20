extends Area2D


signal collect
var collectedTime = 0
var collectedDelay = 1.0
var collected = false

var alreadyEmittedSignal = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not collected:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("collect")
		collectedTime += delta
		if (collectedTime >= collectedDelay):
			queue_free()
	pass


func _on_body_entered(body):
	if body.is_in_group("protagonist"):
		collected = true
		if not alreadyEmittedSignal:
			$AudioStreamPlayer.play()
			emit_signal("collect")
			alreadyEmittedSignal = true
	pass # Replace with function body.
