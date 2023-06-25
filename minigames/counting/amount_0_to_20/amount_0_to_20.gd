extends  "res://minigames/generics/puzzles/amounts/place_position.gd"


func _add_specifics() -> void:
	_add_number_places([1, 2])
	_add_board(1, number_places[1].position + Vector2(-100, -350))
	_add_board(2, number_places[1].position + Vector2(-200, -350))
	_connect_line(number_boards[1], number_places[1])
	_connect_line(number_boards[2], number_places[2])
	_add_number(1)
	change_mode[2] = false

func _end_game_condition() -> bool:
	return number_boards[2].value == 5
