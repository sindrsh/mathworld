extends MiniGame

const Number = preload("res://minigames/generics/puzzles/amounts/number.gd")
const NumberBoard = preload("res://minigames/generics/puzzles/amounts/number_board.gd")
var number_place_scene : PackedScene = preload("res://minigames/generics/puzzles/amounts/number_place.tscn")

var one_texture = preload("res://minigames/div/div_of_amounts/assets/one.svg")
var ten_texture = preload("res://minigames/div/div_of_amounts/assets/ten.svg")
var number_places : Array

var one_board : Node2D
var one_place : Area2D

var dx1 = 50
var dy1 = 50

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

func _add_specifics() -> void:
	one_board = NumberBoard.new()
	one_board.position = Vector2(1000, 100)
	_add_number_place()
	for i in range(9):
		_add_number(1)
	add_child(one_board)
	_connect_line(one_board, one_place)


func _add_number(value : int) -> void:
	var number : Area2D
	if value == 1:
		number = Number.new(one_texture)
	if value == 10:
		number = Number.new(ten_texture)
	add_child(number)
	number.position = Vector2(100,100)


func _add_number_place() -> void:
	one_place = number_place_scene.instantiate()
	one_place.position = Vector2(1000, 500)
	assert(one_place.area_entered.connect(_on_area_entered_board) == 0)
	add_child(one_place)
	

func _on_area_entered_board(_area : Area2D) -> void:
	_area.movable_shape.active = false
	_area.movable_shape.disabled = true
	_area.position = one_place.position + one_positions.pop_back()
	one_board.one_up()
	
	if one_positions.size() == 1:
		await get_tree().create_timer(1.0).timeout
		_end_game()


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
