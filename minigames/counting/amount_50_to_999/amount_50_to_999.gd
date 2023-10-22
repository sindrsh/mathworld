extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

#explanation

func _add_specifics() -> void:
	_add_number_places([1, 2, 3])
	_add_board(1, Vector2(1800, 450))
	_add_board(2, Vector2(1700, 450))
	_add_board(3, Vector2(1600, 450))
	
	
	for i in range(5):
		var number: Area2D = _make_number(2)
#		number.position = number_place_positions[2] + number_positions[2].pop_back()
#		numbers[2].push_back(number)
#		number_boards[2].one_up()
#		add_child(number)
	
	_add_number(1)
	_add_number(2)	
	_add_number(3)
			
func _end_game_condition() -> bool:
	return number_boards[3].value == 9
