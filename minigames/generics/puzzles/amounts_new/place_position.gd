extends MiniGame

var number_board: Sprite2D = preload("res://minigames/generics/puzzles/amounts_new/number_board.tscn").instantiate()
var background := Sprite2D.new()
var background_image : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/background.svg")

var one_place := Sprite2D.new()
var one_place_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/one_place_texture.svg")
var ten_place := Sprite2D.new()
var ten_place_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/ten_place_texture.svg")
var hundred_place := Sprite2D.new()
var hundred_place_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/hundred_place_texture.svg")
var increment_button: PackedScene = preload("res://minigames/generics/puzzles/amounts_new/increment_button.tscn")
var number_scene: PackedScene = preload("res://minigames/generics/puzzles/amounts_new/number.tscn")

var buttons : Array

var number_places := {
	1: one_place,
	2: ten_place,
	3: hundred_place
}

var place_sep := 50.0

var ones := []
var tens := []
var hundreds := []

var numbers := {
	1: ones,
	2: tens,
	3: hundreds
}

var one_texture = preload("res://minigames/generics/puzzles/amounts/assets/one.svg")
var ten_texture = preload("res://minigames/generics/puzzles/amounts/assets/ten.svg")
var hundred_texture = preload("res://minigames/generics/puzzles/amounts/assets/hundred.svg")

var one_y: int = one_texture.get_height()
var ten_x: int = ten_texture.get_width()

var number_textures := {
	1: one_texture,
	2: ten_texture,
	3: hundred_texture
}

var dx1 = 50
var dy1 = 50
var dx10 = 40

var one_positions : Array = [
	Vector2(0, -4*dy1),
	Vector2(0, -3*dy1),
	Vector2(0, -2*dy1),
	Vector2(0, -dy1),
	Vector2(0, 0),	
	Vector2(0, dy1),
	Vector2(0, 2*dy1),
	Vector2(0, 3*dy1),
	Vector2(0, 4*dy1),
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

var number_positions := {
	1: one_positions.duplicate(true),
	2: ten_positions.duplicate(true),
	3: hundred_positions.duplicate(true)
}

func _add_generics() -> void:
	background.texture = background_image
	background.centered = false
	add_child(background)
	
	number_board.position = Vector2(900, 100)
	number_board.choose_board_digits(3)
	add_child(number_board)
	
	one_place.texture = one_place_texture
	ten_place.texture = ten_place_texture
	hundred_place.texture = hundred_place_texture
	
	
	hundred_place.position = Vector2(400, 500)
	ten_place.position = hundred_place.position + Vector2((ten_place.texture.get_width() +hundred_place.texture.get_width())/2.0 + place_sep, 0)
	one_place.position = ten_place.position + Vector2((one_place.texture.get_width() + ten_place.texture.get_width())/2.0 + place_sep, 0)
	add_child(one_place)
	add_child(ten_place)
	add_child(hundred_place)
	
	_add_buttons(one_place, 1)
	_add_buttons(ten_place, 2)
	_add_buttons(hundred_place, 3)


func _add_buttons(digit_place: Sprite2D, place: int) -> void:
	
	var plus : Button = increment_button.instantiate()
	plus.text = "+"
	plus.step = 1
	plus.place = place
	var minus : Button = increment_button.instantiate()
	minus.text = "-"	
	minus.step = -1
	minus.place = place
	
	plus.increment.connect(_on_increment)
	minus.increment.connect(_on_increment)
	plus.position = digit_place.position + Vector2(20, 200)
	minus.position = digit_place.position + Vector2(-20-minus.size.x, 200)
	add_child(plus)
	add_child(minus)
	buttons.push_back(plus)
	buttons.push_back(minus)

func _on_increment(_step: int, _place: int) -> void:
	
	if _step == 1:
		if number_board.digits[_place] < 9:
			_add_number(_place)
		else:
			_on_ten(_place)
		
	if _step == -1:
		if number_board.digits[_place] > 0:
			_remove_number(_place)
			


func _add_number(_place: int) -> void:
	var number: Sprite2D = number_scene.instantiate()
	number.texture = number_textures[_place]
	if number_positions[_place].is_empty():
		print("m")
		return
	number.position = number_places[_place].position + number_positions[_place].pop_back()
	numbers[_place].push_back(number)
	add_child(number)
	number_board.one_up(_place)


func _remove_number(_place: int) -> void:
	var number: Sprite2D = numbers[_place].pop_back()
	number_positions[_place].push_back(number.position - number_places[_place].position)
	number_board.one_down(_place)
	number.queue_free()
	

func _on_ten(_place: int) -> void:
	if _place == 3:
		return
	for button in buttons:
		button.disabled = true
			
	var number: Sprite2D = number_scene.instantiate()
	number.texture = number_textures[_place]
	var vector_step : Vector2
	if _place == 1:
		number.position = number_places[_place + 1].position + number_positions[_place + 1][-1]	+ Vector2(0, 4.5*one_y)
		vector_step = Vector2(0, -one_y)
	if _place == 2:
		number.position = number_places[_place + 1].position + number_positions[_place + 1][-1]	+ Vector2(4.5*ten_x, 0)
		vector_step = Vector2(-ten_x, 0)
	add_child(number)
	await get_tree().create_timer(0.2).timeout
	for i in range(9):
		if _place == 1:
			numbers[_place][i].target = number.position + (i+1)*vector_step
		if _place == 2:
			numbers[_place][-(i+1)].target = number.position + (i+1)*vector_step
		number_board.one_down(_place)
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(0.2).timeout	
	number.queue_free()
	for i in range(numbers[_place].size()):
		numbers[_place][i].queue_free()
	numbers[_place] = []
	
	_add_number(_place + 1)
	if _place == 1:
		number_positions[1] = one_positions.duplicate(true)
	if _place == 2:
		number_positions[2] = ten_positions.duplicate(true)
	for button in buttons:
		button.disabled = false
