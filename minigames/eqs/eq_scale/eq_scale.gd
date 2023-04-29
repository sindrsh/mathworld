extends MiniGame

const Number = preload("res://minigames/eqs/eq_scale/rigid_one.gd")
var plus_one_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_pos.svg")
var minus_one_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_neg.svg")
var x_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_x.svg")
var d = 0
var one = Number.new()
var scale_scene : PackedScene = preload("res://minigames/eqs/eq_scale/scale.tscn") 
var equation_scale : Node2D = scale_scene.instantiate()
var x : float = 3.0
var rigid_one_scene : PackedScene = preload("res://minigames/eqs/eq_scale/rigid_one.tscn")
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	add_child(equation_scale)
	
	$ValidateButton.position = equation_scale.position + Vector2(-$ValidateButton.texture_normal.get_width()/2, -$ValidateButton.texture_normal.get_height()/2.0)
	_scale_freeze(true)

		
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
	print(left_sum, right_sum)
	
func _add_plus_one(_position : Vector2):
	var number = Number.new()
	number.button_texture = plus_one_texture
	number.position = _position
	number.value = 1.0
	add_child(number)
	
	
func _add_minus_one(_position : Vector2):
	var number = Number.new()
	number.button_texture = minus_one_texture
	number.position = _position
	number.value = -1.0
	add_child(number)	


func _add_x(_position : Vector2):
	var number = Number.new()
	number.button_texture = x_texture
	number.position = _position
	number.value = x
	number.mass = x
	add_child(number)
	
	
func _on_restart_pressed():
	equation_scale.queue_free()
	equation_scale = scale_scene.instantiate()
	add_child(equation_scale)
	_scale_freeze(true)


func _on_add_plus_one_pressed():
	_add_plus_one($AddPlusOne.position + Vector2(-50, 25))


func _on_add_minus_one_pressed():
		_add_minus_one($AddMinusOne.position + Vector2(-50, 25))


func _on_add_x_pressed():
		_add_x($AddX.position + Vector2(-75, 25))
