extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

func _add_specifics() -> void:
	_add_number_places([1])
	_add_board(1, number_places[1].position + Vector2(0, -350))
	
	_add_number(1)
	_connect_line(number_boards[1], number_places[1])


func _end_game_condition() -> bool:
	return number_boards[1].value == 9
