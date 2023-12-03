extends MiniGame

var ints = Array(range(1000))
var number_picture : Node2D = preload("res://minigames/counting/make_amounts_0_to_999/number_picture.tscn").instantiate()
var value := 0
var number_board1 : Area2D = preload("res://minigames/counting/make_amounts_0_to_999/number_board1.tscn").instantiate()
var number_board10 : Area2D = preload("res://minigames/counting/make_amounts_0_to_999/number_board10.tscn").instantiate()
var number_board100 : Area2D = preload("res://minigames/counting/make_amounts_0_to_999/number_board100.tscn").instantiate()

var place_width := preload("res://minigames/counting/make_amounts_0_to_999/assets/1a.svg").get_size().x
var place_sep := preload("res://minigames/counting/make_amounts_0_to_999/assets/10a.svg").get_size().x - 2*place_width
var horizontal_sep := 20.0
var boards_sep := 100
var digits : Array[Area2D] = [null, null, null]
var boards_container := Node.new()

func _add_specifics():
	world_part = "counting"
	id = "enter_amounts_0_to_999"
	minigame_type = AMOUNT
	
	assert($AnswerBoard.area_entered.connect(_on_area_entered) == 0)
	
	randomize()
	ints.shuffle()
	
	number_picture.position = Vector2(400, 100)
	$EqualSign.position = number_picture.position + Vector2(800, 200)
	$AnswerBoard.position = $EqualSign.position + Vector2(250, 50)
	$AnswerBoard.get_node("CollisionShape2D").shape.size = $AnswerBoard.get_node("Sprite2D").texture.get_size()
	add_child(number_picture)
	
	
	var start_x = 200
	_mk_number(start_x + 2*boards_sep + 9*place_width + place_sep + 4*horizontal_sep, number_board100, 3)
	_mk_number(start_x + boards_sep + 3*place_width + place_sep + 2*horizontal_sep, number_board10, 2)
	_mk_number(start_x, number_board1, 1)	
	
	add_child(boards_container)
	
	_mk_task()


func _mk_task() -> void:
	value = ints.pop_front()
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("Ones").frame = (value % 100) % 10
	number_picture.arrange()


func _mk_number(x_pos : float, number_node : Area2D, digit_place : int) -> void:
	var number_board : Area2D
	for i in range(9):
		number_board = number_node.duplicate()
		number_board.value = (i + 1)*10**(digit_place - 1)
		number_board.digit_place = digit_place
		number_board.get_node("Numbers").frame = i 
		var texture_width := digit_place*place_width + (digit_place - 1)*place_sep
		@warning_ignore("integer_division")
		number_board.position = Vector2(x_pos + (i/3)*(horizontal_sep + texture_width), 700 + (i % 3)*80)
		number_board.original_position = number_board.position
		boards_container.add_child(number_board)	

func _on_area_entered(area) -> void:
	area.movable_shape.active = false
	if area.digit_place == 1:
		area.position = $AnswerBoard.position + Vector2(place_width + place_sep, 0)
	if area.digit_place == 2:
		area.position = $AnswerBoard.position + Vector2((place_width + place_sep)/2.0, 0)		
	if area.digit_place == 3:
		area.position = $AnswerBoard.position	
	if digits[area.digit_place - 1]:
		digits[area.digit_place - 1].position = digits[area.digit_place - 1].original_position	
	digits[area.digit_place - 1] = area
