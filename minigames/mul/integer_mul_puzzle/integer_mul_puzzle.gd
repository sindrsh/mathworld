extends MiniGame

var movable_card_scene : PackedScene = preload("res://minigames/generics/puzzles/matching_cards/movable_card.tscn")
var board_card_scene : PackedScene = preload("res://minigames/generics/puzzles/matching_cards/board_card.tscn")
var movable_card_normal_texture : Texture2D = preload("res://minigames/mul/integer_mul_puzzle/assets/movable_card.svg")
var board_card_texture : Texture2D = preload("res://minigames/mul/integer_mul_puzzle/assets/board_card.svg")
var card_size : int = movable_card_normal_texture.get_height()
var sep:= 100.0
var y_sep:= 30.0
var x = 150
var y = 120.0

var board_cards : Array
var board_start_x = 710.0
var board_start_y = 380.0
var combinations : Array = [
	[2, 3],
	[2, 4],
	[2, 5],
	[2, 6],
	[3, 4],
	[3, 5], 
	[3, 6],
	[4, 5],
	[4, 6],
	[5, 6],
]


var movable_card_positions : Array = [
	Vector2(x , y),
	Vector2(x + card_size + sep, y),
	Vector2(x + 2*(card_size + sep), y),
	Vector2(x + 3*(card_size + sep), y),
	Vector2(x + 4*(card_size + sep), y),
	Vector2(x + 5*(card_size + sep), y),
	Vector2(x + 5*(card_size + sep), y + card_size + y_sep),	
	Vector2(x + 5*(card_size + sep), y + 2*(card_size + y_sep)),
	Vector2(x + 5*(card_size + sep), y + 3*(card_size + y_sep)),	
	Vector2(x + 4*(card_size + sep), y + card_size + y_sep),				
	Vector2(x + 4*(card_size + sep), y + 2*(card_size + y_sep)),
	Vector2(x + 4*(card_size + sep), y + 3*(card_size + y_sep)),	
	Vector2(x, y + card_size + y_sep),				
	Vector2(x, y + 2*(card_size + y_sep)),
	Vector2(x, y + 3*(card_size + y_sep)),	
	Vector2(x + card_size + sep, y + card_size + y_sep),				
	Vector2(x + card_size + sep, y + 2*(card_size + y_sep)),
	Vector2(x + card_size + sep, y + 3*(card_size + y_sep)),	
]


func _add_specifics() -> void:
	combinations.shuffle()
	
	_make_board()
	for i in range(9):
		var factors = combinations.pop_back()
		_make_card(movable_card_positions.pop_front(), factors, true)
		_make_card(movable_card_positions.pop_front(), [factors[1], factors[0]], false)
		var equal1 := Text.new(40, "=")
		equal1.set_text_position(Vector2(0,-60))
		var equal2 := Text.new(40, "=")
		equal2.set_text_position(Vector2(0,10))
		board_cards[i].add_child(equal1)
		board_cards[i].add_child(equal2)
		var board_expression := Text.new(30, str(factors[0]) + " \u00B7 " + str(factors[1]))
		board_expression.set_text_position(Vector2(0,-90))
		board_cards[i].add_child(board_expression)
		board_cards[i].identity = factors
		
	menu_bar.position = Vector2(-800, 950)
		
		
func _make_card(card_position : Vector2, _factors : Array, upper : bool) -> void:
	var movable_card : Node2D = movable_card_scene.instantiate()
	movable_card.movable_shape.set_txture_normal(movable_card_normal_texture) 
	movable_card.position = card_position
	movable_card.texture_size_div_2 = movable_card_normal_texture.get_size()/2.0
	movable_card.original_position = movable_card.position
	movable_card.identity = _factors
	assert(movable_card.connect("button_released", _on_button_released) == 0)
	
	var txt := str(_factors[0])
	for i in range(_factors[1] - 1):
		txt += "+"+str(_factors[0])
	var expression := Text.new(30, txt)
	movable_card.add_child(expression)
	if upper:
		expression.set_text_position(Vector2(0,-20))
	else:
		expression.set_text_position(Vector2(0,50))	
	add_child(movable_card)
	movable_card.identity.sort()

	
func _make_board() -> void:
	var dx_dy = board_card_texture.get_size()
	for i in range(9):
		var board_card : Node2D = board_card_scene.instantiate()
		board_card.get_node("Sprite2D").texture = board_card_texture	
		@warning_ignore("integer_division")
		board_card.position = Vector2(board_start_x + (i / 3)*dx_dy.x, board_start_y + (i % 3)*dx_dy.y)
		board_cards.push_back(board_card)
		add_child(board_card)
		
		
func _on_button_released(_name : String):
	var card : Node2D = get_node(_name)
	var distance := 100000.0
	var b_card_position := Vector2(0,0)
	var b_card_identity : Array
	for b_card in board_cards:
		if card.position.distance_to(b_card.position) < distance:
			distance = card.position.distance_to(b_card.position)
			b_card_position = b_card.position
			b_card_identity = b_card.identity
			
	if distance < 400:
		if card.identity == b_card_identity:
			card.position = b_card_position
		else:
			card.position = card.original_position
