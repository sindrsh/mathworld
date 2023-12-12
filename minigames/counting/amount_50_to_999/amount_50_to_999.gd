extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

#explanation


func _add_specifics() -> void:
	_add_number_places([1, 2, 3])
	_add_board(3, Vector2(960, 100))
	
	for i in range(5):
		var number: Area2D = _make_number(2)
		number.hide()
		number.monitorable = false
		number.movable_shape.disabled = true
		number_board.one_up(2)
		numbers[2].push_back(number)
		add_child(number)
		number.position = number_place_positions[2] + number_positions[2].pop_back() + number_adjusts[2]
		number.show()
	
	_add_number(1)
	#_add_number(2)	
			
func _end_game_condition() -> bool:
	return number_board.hundreds == 9 and number_board.tens == 9 and number_board.ones == 9
