extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

#explanation

func _add_specifics() -> void:
	world_part = "counting"
	id = "amount_0_to_50"
	
	_add_number_places([1, 2])
	_add_board(1, number_places[1].position + Vector2(-100, -350))
	_add_board(2, number_places[1].position + Vector2(-200, -350))
	_connect_line(number_boards[1], number_places[1])
	_connect_line(number_boards[2], number_places[2])
	_add_number(1)
	change_mode[2] = false

func _end_game_condition() -> bool:
	return number_boards[2].value == 5
