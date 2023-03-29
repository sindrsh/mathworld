extends Area2D

var max_speed := 800
var value := 1


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

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		position.x = _mouse_input(delta).x
	else:
		position.x = _keyboard_input(delta).x
