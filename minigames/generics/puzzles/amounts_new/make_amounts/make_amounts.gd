extends MiniGame

var ints : Array
var number_picture : Node2D = preload("res://minigames/generics/puzzles/amounts_new/number_picture.tscn").instantiate()
var value := 0
var number_card1 : Area2D = preload("res://minigames/generics/puzzles/amounts_new/make_amounts/number_card1.tscn").instantiate()
var number_card10 : Area2D = preload("res://minigames/generics/puzzles/amounts_new/make_amounts/number_card10.tscn").instantiate()
var number_card100 : Area2D = preload("res://minigames/generics/puzzles/amounts_new/make_amounts/number_card100.tscn").instantiate()

var place_width := preload("res://minigames/counting/make_amounts_1_to_99/assets/1a.svg").get_size().x
var place_sep := preload("res://minigames/counting/make_amounts_1_to_99/assets/10a.svg").get_size().x - 2*place_width
var horizontal_sep := 20.0
var boards_sep := 100
var digits : Array[Area2D] = [null, null, null]
var board_positions: Dictionary
var answer_value : int

var equal_sign := TextureButton.new()
var equal_texture_normal : Texture2D =  preload("res://minigames/counting/make_amounts_1_to_99/assets/equal_sign.svg")
var equal_texture_correct: Texture2D = preload("res://minigames/counting/make_amounts_1_to_99/assets/equal_sign_right.svg")
var equal_texture_hover = preload("res://minigames/counting/make_amounts_1_to_99/assets/equal_sign_hover.svg")

var equal_texture_incorrect: Texture2D = preload("res://minigames/counting/make_amounts_1_to_99/assets/equal_sign_wrong.svg")

var answer_board : Area2D = preload("res://minigames/generics/puzzles/amounts_new/make_amounts/answer_board.tscn").instantiate()
var answer_board_sprite_texture : Texture2D


func _add_generics() -> void:
	equal_sign.pressed.connect(_on_equal_sign_pressed)
	assert(answer_board.area_entered.connect(_on_area_entered) == 0)
	
	var background = Sprite2D.new()
	background.centered = false
	background.texture = preload("res://minigames/generics/puzzles/amounts_new/assets/background.svg")
	add_child(background)
	
	randomize()
	
	number_picture.position = Vector2(400, 100)
	equal_sign.position = number_picture.position + Vector2(800, 200)
	answer_board.position = equal_sign.position + Vector2(250, 50)
	
	equal_sign.texture_normal = equal_texture_normal
	equal_sign.texture_hover = equal_texture_hover
	add_child(equal_sign)
	
	
func _physics_process(_delta):
	for area in answer_board.get_overlapping_areas():
		if not area.position in board_positions.values():
			area.movable_shape.active = false
			area.position = area.original_position


func _mk_task() -> void:
	for card in answer_board.get_overlapping_areas():
		card.position = card.original_position
		
	value = ints.pop_front() + 1
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("Ones").frame = (value % 100) % 10
	number_picture.arrange()


func _mk_number(x_pos : float, number_node : Area2D, digit_place : int) -> void:
	var number_card : Area2D
	for i in range(9):
		number_card = number_node.duplicate()
		number_card.value = (i + 1)*10**(digit_place - 1)
		number_card.digit_place = digit_place
		number_card.get_node("Numbers").frame = i 
		var texture_width := digit_place*place_width + (digit_place - 1)*place_sep
		@warning_ignore("integer_division")
		number_card.position = Vector2(x_pos + (i/3)*(horizontal_sep + texture_width), 700 + (i % 3)*80)
		number_card.original_position = number_card.position
		add_child(number_card)


func _on_area_entered(area) -> void:
	area.movable_shape.active = false
	area.placed = true
	
	area.position = board_positions[area.digit_place]
	if digits[area.digit_place - 1]:
		if digits[area.digit_place - 1] != area:
			digits[area.digit_place - 1].position = digits[area.digit_place - 1].original_position	
	digits[area.digit_place - 1] = area
	

func _on_equal_sign_pressed() -> void:
	var answer_value : int
	for card in answer_board.get_overlapping_areas():
		if card.get("value"):
			answer_value += card.value
	if answer_value == value:
		equal_sign.texture_normal = equal_texture_correct
	else:
		equal_sign.texture_normal = equal_texture_incorrect
		if status_bar.frame == 0:
			_end_game_with_failure()
		else:
			status_bar.frame -= 1
		
	equal_sign.disabled = true	
	await get_tree().create_timer(1).timeout
	equal_sign.texture_normal = equal_texture_normal
	equal_sign.disabled = false
	
	_mk_task()
	
