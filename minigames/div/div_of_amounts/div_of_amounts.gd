extends MiniGame

const Number = preload("res://minigames/div/div_of_amounts/number.gd")
var input_box : LineEdit = preload("res://minigames/generics/input_box.tscn").instantiate()

var one_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/one.svg")
var ten_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/ten.svg")
var divisor : int = 3
var quotient : int 
var remainder : int
var group_container := HBoxContainer.new()
var window : Vector2
var dx := 20.0
var start_position : Vector2
var task_text = Text.new(40, "")

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
	
	task_text.set_h_grow_direction(GROW_DIRECTION_BEGIN)
	input_box.position = Vector2(window.x/2, 50)
	task_text.position = input_box.position + Vector2(-25, 20)
	
	add_child(input_box)
	add_child(task_text)
	
	_mk_number()
	
func _mk_number() -> void:
	randomize()
	
	@warning_ignore("integer_division")
	var tens : int = randi_range(0, (10/divisor))
	@warning_ignore("integer_division")
	var ones : int = randi_range(1, (10/divisor)-1)
	quotient = tens*10 + ones
	tens = tens*divisor
	ones = ones*divisor
	
	task_text.set_new_text(str(tens*10+ones) + str(" : ") + str(divisor) + " =")
	
	var texture_size = one_texture.get_size()
	for i in range(ones):
		var one := Number.new()
		one.position = start_position + Vector2(50, i*texture_size.y - 150)
		one.value = 1
		add_child(one)
		one.button_texture = one_texture
		
	for j in range(tens):
		var ten := Number.new()
		ten.position = start_position - Vector2(-50 + (j+2)*ten_texture.get_size().x, 25)
		ten.value = 10
		add_child(ten)
		ten.button_texture = ten_texture


func _on_answer_submitted(answer : String) -> void:
	if int(answer) == quotient:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_correct) 
	else:
		input_box.set("theme_override_styles/read_only", input_box.read_only_box_incorrect) 
	input_box.editable = false	
	await get_tree().create_timer(0.4).timeout
	get_tree().reload_current_scene()
