extends MiniGame

const Number = preload("res://minigames/generics/puzzles/amounts/number.gd")
const NumberBoard = preload("res://minigames/generics/puzzles/amounts/number_board.gd")
var number_place_scene : PackedScene = preload("res://minigames/generics/puzzles/amounts/number_place.tscn")

var one_texture = preload("res://minigames/div/div_of_amounts/assets/one.svg")
var ten_texture = preload("res://minigames/div/div_of_amounts/assets/ten.svg")

var number_places : Dictionary
var number_boards : Dictionary 

var one_board : Node2D
var one_place : Area2D

var place_dx = 300

var dx1 = 50
var dy1 = 50

var dx10 = 50

var one_positions : Array = [
	Vector2(dx1, -2*dy1),
	Vector2(-dx1, -2*dy1),
	Vector2(dx1, -dy1),
	Vector2(-dx1, -dy1),
	Vector2(dx1, 0),
	Vector2(-dx1, 0),
	Vector2(dx1, dy1),
	Vector2(-dx1, dy1),
	Vector2(dx1, 2*dy1),
	Vector2(-dx1, 2*dy1),
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
	Vector2(5*dx10, 0),
]

var number_positions : Dictionary = {
	1: one_positions,
	2: ten_positions
}

func _add_specifics() -> void:
	one_board = NumberBoard.new()
	one_board.position = Vector2(1000, 100)
	number_boards[1] = one_board
	_add_number_places([1, 2])
	for i in range(9):
		_add_number(1)
	add_child(one_board)
	_connect_line(one_board, number_places[1])

func _process(_delta):
	for _number_place in number_places.values():
		for _number in _number_place.get_overlapping_areas():
			if not _number.movable_shape.active:
				if _number.place != _number_place.place:
					_number.position = _number.original_position

func _add_number(place : int) -> void:
	var number : Area2D
	match place:
		1:
			number = Number.new(one_texture)
		2:
			number = Number.new(ten_texture)
	number.place = place
	add_child(number)
	number.position = Vector2(100,100)
	number.original_position = Vector2(100,100)


func _add_number_places(places: Array) -> void:
	var origo = Vector2(1000, 600)
	for i in places:
		var number_place = number_place_scene.instantiate()
		number_place.place = i
		number_place.position = origo + Vector2(-i*place_dx, 0)
		assert(number_place.number_entered.connect(_on_number_entered_board) == 0)
		number_places[i] = number_place
		add_child(number_place)		
	

func _on_number_entered_board(_number : Area2D, _name : String) -> void:
	var _number_place : Area2D = get_node(_name)
	
	if _number.place == _number_place.place:
		_number.movable_shape.active = false
		_number.movable_shape.disabled = true
		_number.position = _number_place.position + one_positions.pop_back()
		number_boards[_number.place].one_up()
#	if one_positions.size() == 1:
#		await get_tree().create_timer(1.0).timeout
#		_end_game()


func _connect_line(board: NumberBoard, number_place: Area2D) -> void:
	var line = Line2D.new()
	line.default_color = Color8(0,0,0)
	line.add_point(board.position + Vector2(0, board.one_board_texture.get_height()/2.0))
	line.add_point(number_place.position + Vector2(0, -number_place.txture.get_height()/2.0))
	add_child(line)


func _end_game_message():
	return "Mini game completed!"


func _end_game() -> void:
	var message = load("res://minigames/generics/SuccessMessage.tscn").instantiate()
	message.get_node("%Label").text = _end_game_message()
	add_child(message)
	
func _end_game_condition() -> bool:
	return false
