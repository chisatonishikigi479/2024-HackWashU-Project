extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://maze_generation_manager.tscn")

func _on_difficulty_button_r_pressed() -> void:
	if Globalvariables.difficulty == "Extreme":
		Globalvariables.difficulty = "Easy"
	else:
		if Globalvariables.difficulty == "Hard":
			Globalvariables.difficulty = "Extreme"
		if Globalvariables.difficulty == "Medium":
			Globalvariables.difficulty = "Hard"
		if Globalvariables.difficulty == "Easy":
			Globalvariables.difficulty = "Medium"
	get_node("MarginContainer/DifficultyLabel").text = str("Difficulty: " + Globalvariables.difficulty)

	

func _on_difficulty_button_l_pressed() -> void:
	if Globalvariables.difficulty == "Easy":
		Globalvariables.difficulty = "Extreme"
	else:
		if Globalvariables.difficulty == "Medium":
			Globalvariables.difficulty = "Easy"
		if Globalvariables.difficulty == "Hard":
			Globalvariables.difficulty = "Medium"
		if Globalvariables.difficulty == "Extreme":
			Globalvariables.difficulty = "Hard"
	get_node("MarginContainer/DifficultyLabel").text = str("Difficulty: " + Globalvariables.difficulty)
