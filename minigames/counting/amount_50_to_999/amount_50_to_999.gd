extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

func _add_specifics() -> void:
	_add_number_places([1, 2, 3])
	_add_board(1, number_places[2].position + Vector2(-100, -300))
	_add_board(2, number_places[2].position + Vector2(-200, -300))
	_add_board(3, number_places[2].position + Vector2(-300, -300))
	
	_add_number(3)
	_connect_line(number_boards[1], number_places[1])
	_connect_line(number_boards[2], number_places[2])
	_connect_line(number_boards[3], number_places[3])

func _end_game_condition() -> bool:
	return number_boards[1].value == 9
