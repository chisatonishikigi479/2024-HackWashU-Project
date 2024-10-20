extends Node2D

var ended = false
var endedTime = 0.0
var endedTimeLimit = 3.0

var totalNumRounds = 5
var currMice = []
var karmalost = 0
var numRoundsSurvived = 0

var alreadyRewarded = false
var indexArray = []

@onready var mousescene = preload("res://mouse.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(totalNumRounds):
		indexArray.append(i)
	
	spawn_mice(1)
	pass # Replace with function body.

func spawn_mice(numMice):
	#$Cat.position = Vector2(640, 360) 
	numRoundsSurvived += 1
	currMice = []
	var indexArrayShuffled = indexArray.duplicate()
	indexArrayShuffled.shuffle()
	for i in range (numMice):
		var targetAngle = (2*PI*indexArrayShuffled[i]) / totalNumRounds
		var mouse = mousescene.instantiate()
		mouse.angle = targetAngle
		add_child(mouse)
		currMice.append(mouse)
		mouse.set_visible(true)
	
func no_mice():
	var allnull = true
	for mouse in currMice:
		if mouse != null:
			allnull = false
	return allnull
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ended:
		endedTime += delta
		if endedTime >= endedTimeLimit:
			queue_free()
			Globalvariables.inMinigame = false
		
		if karmalost == 0:
			if not alreadyRewarded:
				Globalvariables.karma += 10
				alreadyRewarded = true
				$ResultsLabel.text = "Success! +10 Karma"
				$ResultsLabel.visible = true
			pass
			
		else:
			$ResultsLabel.text = "Failed! You lost " + str(karmalost) + " karma"
			$ResultsLabel.visible = true
		
		pass
	else:
		print(currMice.size())
		$KarmaLabel.text = "Karma Lost: " + str(karmalost)
		if no_mice():
			print("no mice")
			if numRoundsSurvived < totalNumRounds:
				$RoundLabel.text = "Round " + str(numRoundsSurvived+1) + " of " + str(totalNumRounds)
				spawn_mice(numRoundsSurvived+1)
			else:
				ended = true
			pass
		
		pass
	pass


func _on_cat_ate_mouse():
	karmalost += 1
	Globalvariables.karma -= 1
	pass # Replace with function body.
