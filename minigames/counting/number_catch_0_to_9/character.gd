extends Node2D

const max_speed := 800
const bottom_margin := 220
var value := 0

func _ready():
	position = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y - bottom_margin) 
	
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


func _move(x):
	var max_a = 0.02
	var speed_a = 0.004
	var d = x - position.x
	return x



func _physics_process(delta):
	var x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		x = _mouse_input(delta).x
	else:
		x = _keyboard_input(delta).x
	
	position.x = _move(x)
