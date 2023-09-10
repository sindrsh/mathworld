extends "res://minigames/generics/falling_bubbles/falling_bubbles.gd"

var ints = Array(range(1000))
var number_picture : Node2D = preload("res://minigames/counting/enter_amounts_0_to_999/number_picture.tscn").instantiate()
var input_box : LineEdit = preload("res://minigames/generics/input_box.tscn").instantiate()
var value := 0


func _ready():
	assert(input_box.text_submitted.connect(_on_answer_submitted) == 0)
	world_part = "counting"
	id = "enter_amounts_0_to_999"
	minigame_type = AMOUNT
	randomize()
	ints.shuffle()
	
	
	number_picture.position = Vector2(200, 200)
	input_box.position = Vector2(1100, 450)
	
	var equal_sign = Text.new(100, "=")
	equal_sign.position = Vector2(1000, 420)
	
	add_child(number_picture)
	add_child(input_box)
	add_child(equal_sign)
	
	
	_mk_task()


func _mk_task() -> void:
	input_box.set("theme_override_styles/read_only", input_box.read_only_box_correct) 
	input_box.editable = true
	input_box.text = ''	
	value = ints.pop_front()
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("Ones").frame = (value % 100) % 10
	number_picture.arrange()


func _on_answer_submitted(answer : String) -> void:
	if int(answer) == value:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_correct) 
	else:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_incorrect) 
	input_box.editable = false	
	await get_tree().create_timer(0.4).timeout
	_mk_task()
