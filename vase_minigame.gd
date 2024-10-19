extends Node2D


var elapsed_time = 0.0
var goal_time = 30.0
var failed = false

var succeeded = false
var endingDelay = 3.0
var endingTime = 0.0

var alreadyIncrementedKarma = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not failed:
		if elapsed_time <= goal_time:
			elapsed_time += delta
			$TimerLabel.text = "Seconds Elapsed: " + str(int(elapsed_time)) + "/" + str(int(goal_time))
		else:
			if not alreadyIncrementedKarma:
				succeeded = true
				Globalvariables.karma += 5
				alreadyIncrementedKarma = true
				#TODO: implement congratulations messages
				$ResultLabel.text = "Success! +5 Karma"
				$ResultLabel.visible = true
				
			endingTime += delta
			if (endingTime >= endingDelay):
				Globalvariables.inMinigame = false
				queue_free()
			
	pass


func _on_vase_vase_broken():
	failed = true
	if not alreadyIncrementedKarma:
		$ResultLabel.text = "Failed! -5 Karma"
		$ResultLabel.visible = true
		Globalvariables.karma -= 5
		print("new karma: " + str(Globalvariables.karma))
		alreadyIncrementedKarma = true
	pass # Replace with function body.
