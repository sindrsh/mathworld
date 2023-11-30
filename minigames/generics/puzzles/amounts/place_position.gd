extends MiniGame

const Number = preload("res://minigames/generics/puzzles/amounts/number.gd")
const NumberBoard = preload("res://minigames/generics/puzzles/amounts/number_board.gd")
const NumberPlace = preload("res://minigames/generics/puzzles/amounts/number_place.gd")

var one_texture = preload("res://minigames/generics/puzzles/amounts/assets/one.svg")
var ten_texture = preload("res://minigames/generics/puzzles/amounts/assets/ten.svg")
var hundred_texture = preload("res://minigames/generics/puzzles/amounts/assets/hundred.svg")

var music : AudioStreamMP3 = preload("res://minigames/generics/assets/little-slime.mp3")

var textures: Dictionary = {
	1: one_texture,
	2: ten_texture,
	3: hundred_texture
}

var number_places : Dictionary
var number_boards : Dictionary
 
var one_board : Node2D
var one_place : Area2D

var place_dx = 300

var dx1 = 50
var dy1 = 60

var dx10 = 35

var tenths: Array
var ones: Array
var tens: Array
var hundreds: Array

var one_y = 380
var ten_y = 500
var hundred_y = 500

var numbers : Dictionary = {
	-1: tenths,
	1: ones,
	2: tens,
	3: hundreds
}

var one_positions : Array = [
	Vector2(-dx1, -4*dy1),
	Vector2(dx1, -3*dy1),
	Vector2(-dx1, -3*dy1),
	Vector2(dx1, -2*dy1),	
	Vector2(-dx1, -2*dy1),
	Vector2(dx1, -dy1),
	Vector2(-dx1, -dy1),
	Vector2(dx1, 0),
	Vector2(-dx1, 0),
]

var ten_positions : Array = [
	Vector2(-4*dx10, 0),
	Vector2(-3*dx10, 0),
	Vector2(-2*dx10, 0),
	Vector2(-1*dx10, 0),
	Vector2(0, 0),
	Vector2(dx10, 0),
	Vector2(2*dx10, 0),
	Vector2(3*dx10, 0),
	Vector2(4*dx10, 0),
]

var diagonal := Vector2(15, -15)
var hundred_positions : Array = [
	-4*diagonal,
	-3*diagonal,
	-2*diagonal,
	-diagonal,
	Vector2(0,0),
	diagonal,
	2*diagonal,
	3*diagonal,
	4*diagonal,
]

var number_positions : Dictionary = {
	1: one_positions,
	2: ten_positions,
	3: hundred_positions
}

var number_adjusts : Dictionary = {
	1: Vector2(0, 175),
	2: Vector2(0, 10),
	3: Vector2(20, 40) 
}

var number_positions_duplicate: Dictionary = number_positions.duplicate(true)

var number_place_positions : Dictionary = {
	1: Vector2(1300, 350),
	2: Vector2(900, 350),
	3: Vector2(400, 350)
}

var change_mode : Dictionary = {
	-1: true,
	1: true,
	2: true,
	3: true
}

func _add_generics() -> void:
	music_player.stream = music

func _add_number(place : int) -> void:
	call_deferred("add_child", _make_number(place))


func _make_number(place: int) -> Area2D:
	var number : Area2D
	match place:
		1:
			number = Number.new(one_texture)
			number.position = number_place_positions[place] + Vector2(0, one_y)
			number.original_position = Vector2(number.position)
		2:
			number = Number.new(ten_texture)
			number.position = number_place_positions[place] + Vector2(0, ten_y)
			number.original_position = Vector2(number.position)
		3:
			number = Number.new(hundred_texture)
			number.position = number_place_positions[place] + Vector2(0, hundred_y)
			number.original_position = Vector2(number.position)
	number.place = place
	return number	


func _add_number_places(places: Array) -> void:
	for i in places:
		var number_place : NumberPlace = NumberPlace.new(i)
		number_place.place = i
		number_place.position = number_place_positions[i]
		assert(number_place.number_entered.connect(_on_number_entered_board) == 0)
		number_places[i] = number_place
		add_child(number_place)		
	
	
func _add_board(place: int, pos: Vector2) -> void:
	var board = NumberBoard.new()
	board.position = pos
	number_boards[place] = board
	add_child(board)


func _on_number_entered_board(_number : Area2D, _name : String) -> void:
	var place = _number.place
	var _number_place : Area2D = get_node(_name)
	_number.movable_shape.set_deferred("active", false)
	if place == _number_place.place:
		_number.movable_shape.disabled = true
		numbers[place].push_back(_number)
		if numbers[place].size() != 10:
			_number.position = _number_place.position + number_adjusts[place] + number_positions[place].pop_back()
			_number_place.indicator.frame += 1
			number_boards[place].one_up()
			if _end_game_condition():
				_end_game()
			else:
				if change_mode[place]:
					_add_number(place)
				else:
					_add_number(place - 1)
		else:
			number_positions[place] = number_positions_duplicate.duplicate(true)[place] 
			_collect_numbers(place)
			_number_place.indicator.frame = 0
	else:
		_number.position = _number.original_position


func _collect_numbers(place: int) -> void:
	var sz = textures[place].get_size()
	var nums = numbers[place]
	for i in [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]:
		if place == 1:
			await get_tree().create_timer(0.3).timeout	
			nums[i].position = number_place_positions[place+1] + Vector2(0, 11.5*sz.y + i*sz.y)
		if place == 2:
			await get_tree().create_timer(0.3).timeout	
			nums[i].position = number_place_positions[place+1] + Vector2(5*sz.x - i*sz.x, hundred_y)
		if i != 0:
				number_boards[place].one_down()
	await get_tree().create_timer(0.3).timeout	
	for j in range(10):
		nums[j].queue_free()
	numbers[place] = []
	await get_tree().create_timer(0.5).timeout	
	_add_number(place + 1)



