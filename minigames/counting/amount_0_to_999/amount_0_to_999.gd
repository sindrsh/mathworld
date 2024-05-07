extends  "res://minigames/generics/puzzles/amounts_new/place_position.gd"

#explanation


func _add_specifics() -> void:
	world_part = "counting"
	id = "amount_0_to_999"
	
	
	number_board.position = Vector2(900, 100)
	number_board.choose_board_digits(3)
	add_child(one_place)
	add_child(ten_place)
	add_child(hundred_place)
	
	_add_buttons(one_place, 1)
	_add_buttons(ten_place, 2)
	_add_buttons(hundred_place, 3)
