extends Area2D

@onready var hawkscene = preload("res://hawk.tscn")

var catprotagonist = null
var alreadysety = false
var ylevel = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if catprotagonist != null:
		if catprotagonist.is_on_floor():
			if not alreadysety:
				ylevel = catprotagonist.position.y - 90
				var hawk = hawkscene.instantiate()
				hawk.position.x = catprotagonist.position.x + 1000
				hawk.position.y = ylevel
				get_parent().add_child(hawk)
				hawk.set_visible(true)
				alreadysety = true
	
	pass


func _on_body_entered(body):
	if body.is_in_group("cat"):
		catprotagonist = body
	pass # Replace with function body.
