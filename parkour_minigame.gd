extends Node2D


var completed = false
var completedTime = 0.0
var completedTimeDelay = 3.0

var distance_goal = 20000
var currDistance = 0
var alreadyIncrementedKarma = false

@onready var preset1scene = preload("res://preset_1.tscn")
@onready var preset2scene = preload("res://preset_2.tscn")
@onready var preset3scene = preload("res://preset_3.tscn")
@onready var preset4scene = preload("res://preset_4.tscn")
@onready var preset5scene = preload("res://preset_5.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	var presetscenes = [preset1scene, preset2scene, preset3scene, preset4scene, preset5scene]
	var validtransitions = [[preset1scene, preset3scene, preset4scene], [preset1scene, preset2scene, preset5scene], [preset1scene, preset4scene], [preset1scene, preset3scene, preset5scene], [preset1scene, preset2scene, preset3scene]]
	
	var validindextransitions = [[1, 3, 4], [1, 2, 5], [1, 4], [1, 3, 5], [1, 2, 3]]
	#randomly generate presets to form a parkour map
	var width = 0
	var height = 0
	var index = randi() % presetscenes.size()
	var preset = presetscenes[index].instantiate()
	
	while width < distance_goal - 2000:
		add_child(preset)
		preset.position = Vector2(width, height)
		print("spawned at " + str(preset.position))
		width += preset.width
		preset.z_index = 400
		if (index == 2):
			print("this is the case")
			if randi() % 2 == 0:
				height -= 400
		preset.set_visible(true)
		var newIndex = validindextransitions[index][randi() % validtransitions[index].size()] - 1
		index = newIndex
		preset = presetscenes[index].instantiate()
		
		
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressLabel.position = $CatCharacter/Camera2D.get_screen_center_position() + Vector2(200, -200)
	$ResultsLabel.position = $CatCharacter/Camera2D.get_screen_center_position() + Vector2(200, -360)
	$BG.position = $CatCharacter/Camera2D.get_screen_center_position()
	currDistance = $CatCharacter.position.x
	
	var percentage = min(100, round(100 * (currDistance / distance_goal)))
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
			get_tree().current_scene.visible = true
			Globalvariables.inMinigame = false
			queue_free()
		pass
	
	pass


func _on_cat_character_died():
	$ResultsLabel.visible = true
	$ResultsLabel.text = "Failed! -5 Karma"
	pass # Replace with function body.
