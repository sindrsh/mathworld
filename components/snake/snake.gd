extends Node2D

# Godot does not have a distinction between private and public properties
# all private properties will be prefixed with an underscore

var _part_scene = preload("res://components/snake_part/snake_part.tscn")
var _parts: Array[SnakePart] = []
var head: SnakePart
var move_dir = Vector2(1, 0)
var _last_move_dir = Vector2(-1, 0)
var next_num = 1

var _collisions_enabled = false  # dumb hack to stop the snake from killing itself instantly
var health = 3
var moving = true

@onready var _mouth: Area2D = get_node("head/Mouth")

signal died()
signal hurt()

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			_parts.append(child)
	
	head = _parts[0]


func _input(event) -> void:
	if event is InputEventScreenDrag:
		var drag_angle: float = event.relative.normalized().angle()
		var degrees: float = rad_to_deg(drag_angle)
		
		# tried a bunch of stuff on desmos to see if there was a mathematical funciton to avoid a stupid else if chain
		# the answer is probably yes but I'm too stupid to figure it out
		# also I converted it to degrees because radians were too brain hurty :(
		if degrees > 45 && degrees < 135:
			move_dir = Vector2(0, 1)
		elif degrees > -45.0 && degrees < 45.0:
			move_dir = Vector2(1, 0)
		elif degrees < -45.0 && degrees > -135:
			move_dir = Vector2(0, -1)
		else:
			move_dir = Vector2(-1, 0)
		


func _process(_delta: float) -> void:
	var left = int(Input.is_action_just_pressed("ui_left"))
	var right = int(Input.is_action_just_pressed("ui_right"))
	var up = int(Input.is_action_just_pressed("ui_up"))
	var down = int(Input.is_action_just_pressed("ui_down"))
	
	if up + left + down + right > 0:
		move_dir = Vector2(right - left, down - up)


func _on_head_at_point() -> void:
	for part in _parts:
		part.teleport()
	_move()


func get_move_dir() -> Vector2:
	if move_dir.length() != 1:
		return _last_move_dir
	
	
	return move_dir


func _move() -> void:
	if !moving:
		return
	
	_last_move_dir = move_dir
	head.goto(head.position + (move_dir * 64))
	
	_mouth.rotation = move_dir.angle()
	
	for i in range(1, len(_parts)):
		var part := _parts[i]
		var ahead := _parts[i - 1]
		part.goto(ahead.position)


func _on_mouth_area_entered(area):
	_mouth_collided(area)


func _on_mouth_body_entered(body):
	_mouth_collided(body)

func eat():
	var part = _part_scene.instantiate()
	
	_parts.append(part)
	call_deferred("add_child", part)
	


func _mouth_collided(node: CollisionObject2D):  # Godot desperately needs type unions
	if !_collisions_enabled:
		return  # hate how this has to be two lines
	
	if (node.get_collision_layer_value(2)):
		if node as NumberFruit:
			node = node as NumberFruit
			if node.number == next_num:
				node.queue_free()
				next_num += 1
				eat()
			else: 
				hurt.emit()
	else:
		print("I died")
		died.emit()


# snake gets invincibility for 0.1s
func _on_timer_timeout():
	_collisions_enabled = true
	pass # Replace with function body


func _on_hurt():
	health -= 1
	if health <= 0:
		died.emit()


func _on_died():
	_mouth.queue_free()
	moving = false
	for part in _parts:
		part.play_die_animation()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
