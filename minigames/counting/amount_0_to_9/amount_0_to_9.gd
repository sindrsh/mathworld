extends  "res://minigames/generics/puzzles/amounts/place_position.gd"

#explanation

var music : AudioStreamMP3 = preload("res://minigames/generics/assets/little-slime.mp3")

func _add_specifics() -> void:
	world_part = "counting"
	id = "amount_0_to_9"
	minigame_type = AMOUNT
	
	_add_number_places([1])
	_add_board(1, number_places[1].position + Vector2(0, -350))
	
	_add_number(1)
	_connect_line(number_boards[1], number_places[1])
	
	music_player.stream = music

func _end_game_condition() -> bool:
	return number_boards[1].value == 9

