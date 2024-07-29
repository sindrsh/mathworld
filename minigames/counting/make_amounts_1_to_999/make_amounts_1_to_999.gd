extends "res://minigames/generics/puzzles/amounts_new/make_amounts/make_amounts.gd"

func _add_specifics():
	id = "make_amounts_1_to_999"
	
	ints = Array(range(51, 1000))
	ints.shuffle()
	
	answer_board_sprite_texture = preload("res://minigames/generics/puzzles/amounts/assets/100board.svg")
	
	board_positions = {
		1: answer_board.position + Vector2(place_width + place_sep, 0),
		2: answer_board.position + Vector2((place_width + place_sep)/2.0, 0),	
		3: answer_board.position
	}
	
	add_child(answer_board)
	answer_board.get_node("Sprite2D").texture = answer_board_sprite_texture
	answer_board.get_node("CollisionShape2D").shape.size = answer_board_sprite_texture.get_size()
	add_child(number_picture)
	
	var start_x = 500
	_mk_number(start_x + 2*boards_sep + 9*place_width + place_sep + 4*horizontal_sep, number_card100, 3)
	_mk_number(start_x + boards_sep + 3*place_width + place_sep + 2*horizontal_sep, number_card10, 2)
	_mk_number(start_x, number_card1, 1)	
	
	_mk_task()
