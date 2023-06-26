extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

func _add_specifics() -> void:
	_add_number_places([1, 2, 3])
	_add_board(1, number_places[2].position + Vector2(50, -350))
	_add_board(2, number_places[2].position + Vector2(-50, -350))
	_add_board(3, number_places[2].position + Vector2(-150, -350))
	
	_connect_line(number_boards[1], number_places[1])
	_connect_line(number_boards[2], number_places[2])
	_connect_line(number_boards[3], number_places[3])
	
	for i in range(5):
		var number: Area2D = _make_number(2)
		number.position = number_place_positions[2] + number_positions[2].pop_back()
		numbers[2].push_back(number)
		number_boards[2].one_up()
		add_child(number)
	
	_add_number(1)
		
func _end_game_condition() -> bool:
	return number_boards[3].value == 9
