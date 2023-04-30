extends MiniGame

const Number = preload("res://minigames/eqs/eq_scale/rigid_one.gd")
var plus_one_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_pos.svg")
var minus_one_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_neg.svg")
var x_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_x.svg")
var x_height : int = x_texture.get_height()
var d = 0
var one = Number.new()
var scale_scene : PackedScene = preload("res://minigames/eqs/eq_scale/scale.tscn") 
var equation_scale : Node2D = scale_scene.instantiate()
var x : float = 3.0
var rigid_one_scene : PackedScene = preload("res://minigames/eqs/eq_scale/rigid_one.tscn")
var t = 0.0
var number_container := Node2D.new()
var max_x_s : int = 1 
var container_matrix : Array = []

var level = 0
var x_int : int
var side1_xes : int
var side2_xes : int
var side1_plus_ones : int
var side2_plus_ones : int
var side1_minus_ones : int
var side2_minus_ones : int


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	var container_size = load("res://minigames/eqs/eq_scale/assets/container_box.svg").get_size()
	@warning_ignore("integer_division", "integer_division")
	for i in range(1, int(container_size.x)/x_texture.get_height()):
		for j in range(1, int(container_size.y)/x_texture.get_height()):
			container_matrix.append(Vector2(i, j))
	add_child(equation_scale)
	add_child(number_container)
	$ValidateButton.position = equation_scale.position + Vector2(-$ValidateButton.texture_normal.get_width()/2, -$ValidateButton.texture_normal.get_height())
	_scale_freeze(true)
	_make_equation()
	_distribute()
		
func _scale_freeze(_freeze : bool) -> void:
	for child in equation_scale.get_children():
		if child as RigidBody2D:
			child.freeze = _freeze	


func _get_sum(area : Area2D) -> float:
	var sum : float = 0.0
	for object in area.get_overlapping_bodies():
		if object as Number:
			sum += object.value
	return sum


func _on_validate_button_pressed():
	var left_sum = _get_sum(equation_scale.get_node("LeftSide").get_node("Container"))
	var right_sum = _get_sum(equation_scale.get_node("RightSide").get_node("Container"))
	if left_sum > right_sum:
#		equation_scale.get_node("LeftSide").mass = 2.0
		_scale_freeze(false)
	elif right_sum > left_sum:
#		equation_scale.get_node("RightSide").mass = 2.0 
		_scale_freeze(false)
	
func _add_plus_one(_position : Vector2, moved := false):
	var number = Number.new()
	number.button_texture = plus_one_texture
	number.position = _position
	number.value = 1.0
	number.moved = moved
	number_container.add_child(number)
	
	
func _add_minus_one(_position : Vector2, moved := false):
	var number = Number.new()
	number.button_texture = minus_one_texture
	number.position = _position
	number.value = -1.0
	number.moved = moved
	number_container.add_child(number)	


func _add_x(_position : Vector2, moved := false):
	var number = Number.new()
	number.button_texture = x_texture
	number.position = _position
	number.value = x
	number.mass = x
	number.moved = moved
	number_container.add_child(number)
	
	
func _on_restart_pressed():
	equation_scale.queue_free()
	equation_scale = scale_scene.instantiate()
	number_container.queue_free()
	number_container = Node2D.new()
	add_child(equation_scale)
	add_child(number_container)
	_scale_freeze(true)
	_distribute()

func _make_equation() -> void:
	side1_xes = 0
	side2_xes = 0
	side1_plus_ones = 0
	side2_plus_ones = 0
	side2_minus_ones = 0
	side2_minus_ones = 0
		
	if level == 1:
		x = randi() % 5 +1
		x_int = int(x)
		side1_xes = 1
		side2_plus_ones = randi_range(x_int+2, 7)
		side1_plus_ones = side2_plus_ones - x_int
	
	if level == 2:
		x = randi() % 5 +1
		x_int = int(x)
		side1_xes = 1
		side1_minus_ones = randi_range(1, x_int)
		side2_plus_ones = x_int - side1_minus_ones

	if level == 3:
		x = randi() % 4 +1
		x_int = int(x)
		side1_xes = randi() % 4 + 2
		side2_xes = randi_range(1, side1_xes-1)
		side1_minus_ones = randi() % 4
		var sum = (side1_xes - side2_xes)*x_int - side1_minus_ones
		if sum > 0:
			side2_plus_ones = sum
		if sum < 0:
			side2_minus_ones = -sum

func _distribute() -> void:
	randomize()
	var box_width = equation_scale.get_node("LeftSide").get_node("ContainerSprite").texture.get_width()
	var side1_pos : Vector2 = equation_scale.get_node("LeftSide").global_position - Vector2(box_width/2.0, 0)
	var side2_pos : Vector2 = equation_scale.get_node("RightSide").global_position - Vector2(box_width/2.0, 0)
	if randi() % 2 == 0:
		side1_pos = equation_scale.get_node("RightSide").global_position - Vector2(box_width/2, 0)
		side2_pos = equation_scale.get_node("LeftSide").global_position - Vector2(box_width/2, 0)
	
	var position_matrix1 = container_matrix.duplicate(true)
	var position_matrix2 = container_matrix.duplicate(true)
	position_matrix1.shuffle()
	position_matrix2.shuffle()
	
	for i in range(side1_xes):
		_add_x(side1_pos + position_matrix1.pop_back()*Vector2(x_height, x_height), true)
	for i in range(side2_xes):
		_add_x(side2_pos + position_matrix2.pop_back()*Vector2(x_height, x_height), true)
	for i in range(side1_plus_ones):
		_add_plus_one(side1_pos + position_matrix1.pop_back()*Vector2(x_height, x_height), true)
	for i in range(side2_plus_ones):
		_add_plus_one(side2_pos + position_matrix2.pop_back()*Vector2(x_height, x_height), true)
	for i in range(side1_minus_ones):
		_add_minus_one(side1_pos + position_matrix1.pop_back()*Vector2(x_height, x_height), true)	
	for i in range(side2_minus_ones):
		_add_minus_one(side2_pos + position_matrix2.pop_back()*Vector2(x_height, x_height), true)
	
		
func _on_add_plus_one_pressed() -> void:
	_add_plus_one($AddPlusOne.position + Vector2(-50, 25))


func _on_add_minus_one_pressed() -> void:
		_add_minus_one($AddMinusOne.position + Vector2(-50, 25))


func _on_add_x_pressed() -> void:
		_add_x($AddX.position + Vector2(-75, 25))


func _on_level_1_pressed():
	level = 1
	_make_equation()
	_on_restart_pressed()
	

func _on_level_2_pressed():
	level = 2
	_make_equation()
	_on_restart_pressed()


func _on_level_3_pressed():
	level = 3
	_make_equation()
	_on_restart_pressed()
