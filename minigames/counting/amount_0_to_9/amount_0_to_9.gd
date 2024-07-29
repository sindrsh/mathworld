extends  "res://minigames/generics/puzzles/amounts_new/place_position.gd"

#explanation

func _add_specifics() -> void:
	id = "amount_0_to_9"
	
	number_board.position = Vector2(one_place.position.x, 100)
	ten_shift_allowed[1] = false
	add_child(one_place)
	number_board.choose_board_digits(1)
	_add_buttons(one_place, 1)
