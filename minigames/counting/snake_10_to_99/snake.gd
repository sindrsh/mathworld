extends MiniGame

var number_picture : Node2D = preload("res://minigames/generics/puzzles/amounts_new/number_picture.tscn").instantiate()
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right
var snake_parts := []
var fake_parts := []
var time_interval := 0.0
var previous_positions = []
var move_allowed := false
var fake = true
var input_keys := []
var _entered_direction : Vector2
var ints : Array
var value : int
var tile_size := 56
var tile_positions : Array
var tile_matrix_index : Dictionary
var fruit_positions : Array
var first_key := true
var mouse_is_pressed := false
var prev_mouse_pos := Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _add_generics() -> void:
	$FakeFront.area_entered.connect(_on_area_entered)
	$Timer.timeout.connect(_on_timeout)
	snake_parts.push_back($SnakeFront)
	fake_parts.push_back($FakeFront)
	randomize()
	ints = range(10, 100)
	ints.shuffle()
	
	
	_set_number_picture_size(Vector2(180, 300))
	add_child(number_picture)
	
	for i in range(1920/tile_size):
		for j in range(1080/tile_size):
			tile_matrix_index[tile_positions.size()] = Vector2i(i, j)
			tile_positions.push_back(Vector2(8, 8) + tile_size*Vector2(i, j) + tile_size*Vector2(0.5, 0.5))
			var panel := $Panel2.duplicate()
			panel.position = tile_positions[-1] - tile_size*Vector2(0.5, 0.5)
			add_child(panel)
			var text := Label.new()
			text.text = str(i)+ ',' + str(j) + ';' + str(tile_positions.size()-1)
			panel.add_child(text)
		
	
	var object_positions : Array
	for i in range(tile_positions.size()):
		if tile_matrix_index[i].x > 2 and tile_matrix_index[i].y > 4:
			object_positions.push_back(tile_positions[i])
	object_positions.shuffle()
	
	var temp_ints = []
	for j in range(9):
		var i = ints.pop_back()
		var fruit : Area2D = $Fruit.duplicate()
		temp_ints.push_back(i)
		fruit.value = i
		fruit.position = object_positions.pop_back()
		fruit_positions.push_back(fruit.position)
		fruit.visible = true
		fruit.get_node("Label").set_new_text(str(i))
		fruit.get_node("Label").center_text()
		add_child(fruit)
	ints = temp_ints
	
	$SnakeFront.position = object_positions[0]
	$FakeFront.position = $SnakeFront.position	
	_mk_task()	
	

	_add_part_to_snake()
	_add_part_to_snake()		

func _add_specifics() -> void:
	id = "snake_10_to_99"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_timeout() -> void:
	if move_allowed:
		if input_keys:
			match input_keys[0]:
				KEY_LEFT:
					_entered_direction = left
				KEY_RIGHT:
					_entered_direction = right
				KEY_UP:
					_entered_direction = up
				KEY_DOWN:
					_entered_direction = down
				_:
					_entered_direction = direction
			if _entered_direction != -direction:
				direction = _entered_direction
			input_keys = []
		for i in range(snake_parts.size()):
			snake_parts[i].position = fake_parts[i].position
		_move_fake_snake()
		
		
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if first_key: 
			move_allowed = true
			$Timer.start()
			first_key = false
		input_keys.push_front(event.keycode)
	if event is InputEventMouseButton:
		mouse_is_pressed = ! mouse_is_pressed
		
	if event is InputEventMouseMotion and mouse_is_pressed:
		var mouse_direction: Vector2 = event.position.direction_to(prev_mouse_pos)
		var mouse_key_code : int = KEY_RIGHT
		if abs(mouse_direction.x) > abs(mouse_direction.y):
			if mouse_direction.x >= 0:
				mouse_key_code = KEY_LEFT
		else:
			if mouse_direction.y >= 0:
				mouse_key_code = KEY_UP
			else:
				mouse_key_code = KEY_DOWN
	
		input_keys.push_front(mouse_key_code)		
		prev_mouse_pos = event.position

func _add_part_to_snake() -> void:
	var snake_part : Area2D = $SnakePart.duplicate()
	snake_part.visible = true
	snake_part.position = snake_parts[snake_parts.size()-1].position - tile_size*direction 
	snake_parts.push_back(snake_part)
	add_child(snake_part)
	
	var fake_part : Area2D = $FakePart.duplicate()
	fake_part.position = fake_parts[fake_parts.size()-1].position - tile_size*direction 
	fake_parts.push_back(fake_part)
	add_child(fake_part)


func _move_fake_snake():
	fake_parts[0].position += tile_size*direction  
	for i in range(1, snake_parts.size()):
		fake_parts[i].position = snake_parts[i-1].position


func _on_area_entered(area: Area2D):
	var sound : AudioStreamPlayer2D = $IncorrectSound
	var is_crashing = true
	if area.get("value"):
		print(area.value)
		if area.value == value:
			is_crashing = false
			area.call_deferred("queue_free")
			_mk_task()
			sound = $CorrectSound
			call_deferred("_add_part_to_snake")
	sound.play()		
	move_allowed = not is_crashing


func _mk_task() -> void:
	if ints.is_empty():
		_game_completed()
		return
	value = ints.pop_front()
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("Ones").frame = value % 10
	number_picture.arrange()
	number_picture.get_node("OnesAlt").position -= Vector2(55,70)


func _set_number_picture_size(_size: Vector2) -> void:
	number_picture.get_node("Panel").size = _size
	var num_pic_area := Area2D.new()
	num_pic_area.monitoring = false
	var num_pic_collision_object := CollisionShape2D.new()
	var num_pic_collision_shape := RectangleShape2D.new()
	num_pic_collision_shape.size = _size
	num_pic_collision_object.shape = num_pic_collision_shape
	num_pic_area.position = _size/2.0
	num_pic_area.add_child(num_pic_collision_object)
	number_picture.add_child(num_pic_area)
	
