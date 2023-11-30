extends MiniGame

var ints = Array(range(1000))
var number_picture : Node2D = preload("res://minigames/counting/make_amounts_0_to_999/number_picture.tscn").instantiate()
var value := 0
var number_board1 = preload("res://minigames/counting/make_amounts_0_to_999/number_board1.tscn").instantiate()
var number_board10 = preload("res://minigames/counting/make_amounts_0_to_999/number_board10.tscn").instantiate()
var number_board100 = preload("res://minigames/counting/make_amounts_0_to_999/number_board100.tscn").instantiate()

func _add_specifics():
	world_part = "counting"
	id = "enter_amounts_0_to_999"
	minigame_type = AMOUNT
	randomize()
	ints.shuffle()
	
	number_picture.position = Vector2(200, 200)
	
	var equal_sign = Text.new(100, "=")
	equal_sign.position = Vector2(1000, 420)
	
	add_child(number_picture)
	add_child(equal_sign)
	
	var number_board : Area2D
	for i in range(10):
		number_board = number_board1.duplicate()
		number_board.position = Vector2(200, 500 + i*80)
		add_child(number_board)
	
	for i in range(10):
		number_board = number_board10.duplicate()
		number_board.position = Vector2(500, 500 + i*80)
		add_child(number_board)	
	
	for i in range(10):
		number_board = number_board100.duplicate()
		number_board.position = Vector2(800, 500 + i*80)
		add_child(number_board)			
	
	_mk_task()


func _mk_task() -> void:
	value = ints.pop_front()
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("Ones").frame = (value % 100) % 10
	number_picture.arrange()


