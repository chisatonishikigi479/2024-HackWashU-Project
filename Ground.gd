extends StaticBody2D

@onready var cat = get_parent().get_node("CatCharacter")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cat:
		position.x = cat.position.x + 500
	pass
