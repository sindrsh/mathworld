extends Area2D

var speed = 800
var velocity := Vector2(0,0)
var value := 1

func _ready():
	position = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y - 100) 
	
func _get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector2(input_direction.x, 0) * speed
	
func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var x_distance : float = position.x-get_global_mouse_position().x
		velocity = Vector2(-1, 0) * x_distance/abs(x_distance) * speed
	else:
		_get_input()
	position = delta*velocity + position
