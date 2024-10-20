extends Node2D


var completed = false
var completedTime = 0.0
var completedTimeDelay = 3.0

var distance_goal = 10000
var currDistance = 0
var alreadyIncrementedKarma = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressLabel.position = $CatCharacter/Camera2D.get_screen_center_position() + Vector2(200, -200)
	$ResultsLabel.position = $CatCharacter/Camera2D.get_screen_center_position() + Vector2(200, -360)
	currDistance = $CatCharacter.position.x
	
	var percentage = min(100, round(100 * (currDistance / 10000)))
	$ProgressLabel.text = "Progress: " + str(percentage) + "%"
	
	if percentage >= 100:
		completed = true
		
	if completed:
		$ResultsLabel.text = "Completed! +5 Karma"
		$ResultsLabel.visible = true
		if not alreadyIncrementedKarma:
			Globalvariables.karma += 5
			alreadyIncrementedKarma = true
		completedTime += delta
		if completedTime >= completedTimeDelay:
			Globalvariables.inMinigame = false
			queue_free()
		pass
	
	pass


func _on_cat_character_died():
	$ResultsLabel.visible = true
	$ResultsLabel.text = "Failed! -5 Karma"
	pass # Replace with function body.
