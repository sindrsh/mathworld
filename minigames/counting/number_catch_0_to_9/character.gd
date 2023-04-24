extends Node2D

var max_speed := 800
var value := 1
var swing = 0

func _ready():
	position = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y - 100) 
	
func _keyboard_input(delta) -> Vector2:
	var input_direction : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var velocity := input_direction * max_speed
	return position + velocity * delta


func _mouse_input(delta) -> Vector2:
	var mouse_position := get_global_mouse_position()
	var x_distance : float = mouse_position.x - position.x
	var max_distance : float = max_speed * delta
	if abs(x_distance) > max_distance:
		var input_direction := Vector2(x_distance / abs(x_distance), 0)
		var velocity := input_direction * max_speed
		return position + velocity * delta
	else:
		return mouse_position


func _move_and_rotate(x):
	var a = get_node('number_container').rotation
	var max_a = 0.02
	var speed_a = 0.004
	var d = x - position.x
	if (d > 0 and a < max_a):
		_rotate_childs(speed_a)
	if (d < 0 and a > -max_a):
		_rotate_childs(-speed_a)
	else:
		_rotate_childs(sin(swing)*0.0005)
	return x


func _rotate_childs(speed_a):
	var node = self
	var a = speed_a
	for n in value:
		if (node.has_node('number_container')): 
			node = node.get_node('number_container')
			node.rotation += a

func _physics_process(delta):
	swing += 0.04
	var x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		x = _mouse_input(delta).x
	else:
		x = _keyboard_input(delta).x
	
	position.x = _move_and_rotate(x)
