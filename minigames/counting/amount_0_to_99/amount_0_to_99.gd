extends  "res://minigames/generics/puzzles/amounts_new/place_position.gd"

#explanation

func _add_specifics() -> void:
	world_part = "counting"
	id = "amount_0_to_99"
	
	number_board.position = Vector2(1100, 100)
	number_board.choose_board_digits(2)
	ten_shift_allowed[2] = false
	add_child(one_place)
	add_child(ten_place)
	
	_add_buttons(one_place, 1)
	_add_buttons(ten_place, 2)

