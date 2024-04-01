extends Control

var up = Vector2(0, -1)
var down = Vector2(0, 1)
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right
var speed : float
var snake_parts := []
var fake_parts := []
var time_interval := 0.0
var previous_positions = []
var move_allowed := true
var fake_move_allowed := true
var fake = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SnakeFront.area_entered.connect(_on_area_entered)
	speed = $SnakeFront.get_node("Panel").size.x
	snake_parts.push_back($SnakeFront)
	fake_parts.push_back($FakeFront)
	$SnakeFront.position = Vector2(200, 200)
	$FakeFront.position = $SnakeFront.position
	_add_part_to_snake()
	_add_part_to_snake()
	_add_part_to_snake()
	_add_part_to_snake()
	_add_part_to_snake()
	_add_part_to_snake()
	_add_part_to_snake()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if fake_move_allowed and move_allowed:
		previous_positions = []
		for part in snake_parts:
			previous_positions.push_back(part.position)
		_move_snake(fake_parts)
		fake_move_allowed = false
	if time_interval > 2 and move_allowed:
		for i in range(snake_parts.size()):
			snake_parts[i].position = fake_parts[i].position
		fake_move_allowed = true
		time_interval = 0
	else:
		time_interval += delta


func _input(event: InputEvent) -> void:
	var _entered_direction : Vector2
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_LEFT:
				_entered_direction = left
			KEY_RIGHT:
				_entered_direction = right
			KEY_UP:
				_entered_direction = up
			KEY_DOWN:
				_entered_direction = down
		if _entered_direction != -direction:
			direction = _entered_direction


func _add_part_to_snake() -> void:
	var snake_part : Area2D = $SnakePart.duplicate()
	snake_part.visible = false
	snake_part.position = snake_parts[snake_parts.size()-1].position - $SnakeFront.get_node("Panel").size*direction 
	snake_parts.push_back(snake_part)
	add_child(snake_part)
	
	var fake_part : Area2D = $FakePart.duplicate()
	fake_part.position = fake_parts[fake_parts.size()-1].position - $SnakeFront.get_node("Panel").size*direction 
	fake_parts.push_back(fake_part)
	add_child(fake_part)


func _move_snake(snake_array: Array) -> void:
	for i in range(snake_array.size()):
		if i == 0:
			snake_array[i].position += speed*direction
		else:
			snake_array[i].position = previous_positions[i-1]	


func _on_area_entered(area: Area2D) -> void:
	print("??")
	move_allowed = false


	
