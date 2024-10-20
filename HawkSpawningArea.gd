extends Area2D

@onready var hawkscene = preload("res://hawk.tscn")

var catprotagonist = null
var alreadysety = false

var buffer = 0
var bufferLimit = 0.25
var ylevel = 0
var canspawn = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	pass


func _on_body_entered(body):
	if body.is_in_group("cat"):
		catprotagonist = body
		if catprotagonist != null:
			if catprotagonist.is_on_floor():
				if (not alreadysety) and canspawn:
					ylevel = catprotagonist.position.y - 90
					var hawk = hawkscene.instantiate()
					get_parent().get_parent().add_child(hawk)
					hawk.position.x = catprotagonist.position.x + 1000
					print("contacted at " + str(catprotagonist.position.x))
					hawk.position.y = ylevel
					hawk.set_visible(true)
					alreadysety = true
			else:
				alreadysety = true
				canspawn = false
	pass # Replace with function body.
