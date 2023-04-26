extends MiniGame

const Number = preload("res://minigames/eqs/eq_scale/number.gd")
var one_texture : Texture2D = preload("res://minigames/eqs/eq_scale/assets/circle_white.svg")
var d = 0
var one = Number.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	one.button_texture = one_texture
	one.position = Vector2(600, 100)
	one.value = 1.0
	add_child(one)
	_scale_freeze(true)
	

func _scale_freeze(_freeze : bool) -> void:
	for child in $Scale.get_children():
		if child as RigidBody2D:
			child.freeze = _freeze	


func _get_sum(area : Area2D) -> float:
	var sum : float = 0.0
	for object in area.get_overlapping_bodies():
		if object as Number:
			sum += object.value
	return sum


func _on_validate_button_pressed():
	var left_sum = _get_sum($Scale/LeftSide/Container)
	var right_sum = _get_sum($Scale/RightSide/Container)
	if left_sum > right_sum:
		$Scale/LeftSide.mass = 2.0
		_scale_freeze(false)
	elif right_sum > left_sum:
		$Scale/RightSide.mass = 2.0 
		_scale_freeze(false)
	
