extends MiniGame

#explanation

const Number = preload("res://minigames/div/div_of_amounts/number.gd")
var input_box : LineEdit = preload("res://minigames/generics/input_box.tscn").instantiate()

var one_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/one.svg")
var ten_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/ten.svg")
var divisor : int 
var quotient : int 
var remainder : int
var group_container := HBoxContainer.new()
var window : Vector2
var dx := 20.0
var start_position : Vector2
var task_text = Text.new(40, "")
var cutter_is_active := false
var level : int = 1
var numbers_container := Node2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	assert(input_box.text_submitted.connect(_on_answer_submitted) == 0)
	
	window = get_viewport_rect().size
	start_position = Vector2(window.x/2, 400)
		
	var dividend_group : Area2D = preload("res://minigames/div/div_of_amounts/total_group.tscn").instantiate()
	dividend_group.position = Vector2(window.x/2, start_position.y-25)	
	dividend_group._arrange(Vector2(1000, 330))

	add_child(dividend_group)
	
	task_text.set_h_grow_direction(GROW_DIRECTION_BEGIN)
	input_box.position = Vector2(window.x/2, 50)
	task_text.position = input_box.position + Vector2(-25, 20)
	
	add_child(input_box)
	add_child(task_text)
	
	_mk_task()
	
func _mk_task() -> void:
	group_container.queue_free()
	group_container = HBoxContainer.new()
	group_container.set("theme_override_constants/separation", 350)
	group_container.set_alignment(group_container.ALIGNMENT_CENTER)
	group_container.size = Vector2(window.x, 800)
	group_container.position.y = start_position.y + 400

	divisor = randi() % 4 + 2
	for i in range(divisor):
		var cntrl := Control.new()
		var new_group: Area2D = preload("res://minigames/div/div_of_amounts/group.tscn").instantiate()
		new_group._arrange(Vector2(310, 330))
		cntrl.add_child(new_group)
		group_container.add_child(cntrl)
	add_child(group_container)
	
	input_box.set("theme_override_styles/read_only", input_box.read_only_box_correct) 
	input_box.editable = true
	input_box.text = ''
	numbers_container.queue_free()
	numbers_container = Node2D.new()
	add_child(numbers_container)
	_mk_number()

func _mk_number() -> void:
	randomize()
	
	var _tens_and_ones = _get_tens_and_ones()
	
	var tens = _tens_and_ones[0]
	var ones = _tens_and_ones[1]
	
	task_text.set_new_text(str(tens*10+ones) + str(" : ") + str(divisor) + " =")
	
	var texture_size = one_texture.get_size()
	for i in range(ones):
		var one := Number.new()
		one.position = start_position + Vector2(50, i*texture_size.y - 150)
		one.value = 1
		numbers_container.add_child(one)
		one.button_texture = one_texture
		
		
	for j in range(tens):
		var ten := Number.new()
		ten.position = start_position - Vector2(-50 + (j+2)*ten_texture.get_size().x, 25)
		ten.value = 10
		numbers_container.add_child(ten)
		ten.button_texture = ten_texture
		assert(ten.shape_pressed.connect(_on_ten_pressed) == 0)

func _get_tens_and_ones() -> PackedInt32Array:
	var tens : int
	var ones : int
	if level == 1:
		@warning_ignore("integer_division")
		tens = randi_range(0, (10/divisor) - 1)
		@warning_ignore("integer_division")
		ones = randi_range(1, (10/divisor) - 1)
		quotient = tens*10 + ones
		tens = tens*divisor
		ones = ones*divisor
	if level == 2:
		var possible_dividends : Array = []
		@warning_ignore("integer_division")
		var max_dig = 10 / divisor
		if 10 % divisor == 0:
			max_dig -= 1
		var max_quotient = max_dig*11 
		for i in range(1, max_quotient):
			@warning_ignore("integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division", "integer_division")
			if ((i*divisor)/10) % divisor != 0:
				possible_dividends.append(i*divisor) 
		possible_dividends.shuffle()
		var dividend : int = possible_dividends.pop_back()
		@warning_ignore("integer_division")
		tens = dividend/10
		ones = dividend - tens*10
		@warning_ignore("integer_division")
		quotient = dividend/divisor
		
	return [tens, ones]	


func _on_answer_submitted(answer : String) -> void:
	if int(answer) == quotient:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_correct) 
	else:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_incorrect) 
	input_box.editable = false	
	await get_tree().create_timer(0.4).timeout
	_mk_task()


func _on_cutter_pressed() -> void:
	cutter_is_active = true


func _on_ten_pressed(_name : String) -> void:
	if cutter_is_active:
		var ten : Number = numbers_container.get_node(NodePath(_name))
		var one_start : Vector2 = ten.position + Vector2(0, -ten_texture.get_size().y/2.0 + one_texture.get_height()/3.0)
		ten.queue_free()
		var texture_size : Vector2 = one_texture.get_size()
		for i in range(10):
			var one := Number.new()
			one.position = one_start + Vector2(0, i*texture_size.y)
			one.value = 1
			numbers_container.add_child(one)
			one.button_texture = one_texture
	cutter_is_active = false
	
func _on_level_1_pressed() -> void:
	level = 1
	$Cutter.hide()
	_mk_task()


func _on_level_2_pressed() -> void:
	level = 2
	$Cutter.show()
	_mk_task()
