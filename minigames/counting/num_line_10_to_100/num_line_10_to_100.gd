extends MiniGame

#explanation

func _add_specifics():
	assert($NumberLine.rolled.connect(_on_number_line_rolled) == 0)
	
	world_part = "counting"
	id = "num_line_0_to_9"
	minigame_type = NUMBER_LINE
	$NumberLine.position = Vector2(900, 500)
	$NumberLine.roll_ten()
	
	
func _on_number_line_rolled() -> void:
	$NumberLine.add_ten()
