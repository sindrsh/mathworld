extends Control

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
var fake_move_allowed := true
var fake = true
var input_keys := []
var _entered_direction : Vector2
var ints : Array
var value : int
var tile_size := 80
var tile_positions : Array
var fruit_positions : Array
var first_key := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FakeFront.area_entered.connect(_on_area_entered)
	$Timer.timeout.connect(_on_timeout)
	snake_parts.push_back($SnakeFront)
	fake_parts.push_back($FakeFront)
	randomize()
	ints = range(9)
	ints.shuffle()
	add_child(number_picture)
	number_picture.get_node("Panel").size = Vector2(200, 300)
	
	for i in range(1, 1920/tile_size):
		for j in range(1, 1080/tile_size):
			tile_positions.push_back(tile_size*Vector2(i, j))
	tile_positions.shuffle()
	
	for i in ints:
		var fruit : Area2D = $Fruit.duplicate()
		fruit.value = i + 1
		fruit.position = tile_positions.pop_back()
		fruit_positions.push_back(fruit.position)
		fruit.visible = true
		fruit.get_node("Label").set_new_text(str(i + 1))
		fruit.get_node("Label").center_text()
		add_child(fruit)
	
	_mk_task()	
	
	for tile_position in tile_positions:
		var distance: float
		for fruit_position in fruit_positions:
			if tile_position.distance_to(fruit_position) > distance:
				distance = tile_position.distance_to(fruit_position)
		if distance > 20*tile_size:
			$SnakeFront.position = tile_position
			$FakeFront.position = $SnakeFront.position
			break
	_add_part_to_snake()
	_add_part_to_snake()		


	
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
		if area.value == value:
			is_crashing = false
			area.call_deferred("queue_free")
			_mk_task()
			sound = $CorrectSound
			call_deferred("_add_part_to_snake")
	sound.play()		
	move_allowed = not is_crashing


func _mk_task() -> void:
	value = ints.pop_front() + 1
	@warning_ignore("integer_division")
	number_picture.get_node("Hundreds").frame = value/100
	@warning_ignore("integer_division")
	number_picture.get_node("Tens").frame = (value % 100)/10
	number_picture.get_node("OnesAlt").frame = value
	number_picture.arrange()


