extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$HeavenMusic.play()
	$BribeButton/FishLabel.text = "Bribe with collected fish (" + str(Globalvariables.fishkarma) + ")"
	$BribeButton.visible = Globalvariables.fishkarma > 0
	$CatGod.isHappy = Globalvariables.karma >= 0
	if Globalvariables.karma >= 0:
		$FinalKarmaCount.text = "Total karma: " + str(Globalvariables.karma) + " (positive). You are sent to heaven."
	else:
		$FinalKarmaCount.text = "Total karma: " + str(Globalvariables.karma) + " (negative). You are sent to hell."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_bribe_button_bribed():
	$BribeButton/FishLabel.text = "Bribed"
	Globalvariables.karma += Globalvariables.fishkarma
	
	$CatGod.isHappy = Globalvariables.karma >= 0
	if Globalvariables.karma >= 0:
		$FinalKarmaCount.text = "Total karma: " + str(Globalvariables.karma) + " (positive). You are sent to heaven, but only because you bribed me."
	else:
		$FinalKarmaCount.text = "Total karma: " + str(Globalvariables.karma) + " (negative). Even your fish weren't enough to entice me."
	
	pass # Replace with function body.
