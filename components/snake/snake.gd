extends Node2D

# Wherever this object is will be the initial "root" of the snake
var part_scene = preload("res://components/snake_part/snake_part.tscn")
var queue: TimedInputQueue
var head: SnakePart
var direction: Vector2 = Vector2(1, 0)
var health = 5

func spawn_snake(pos: Vector2 = Vector2(0, 0), starting_parts: int = 4) -> void:
	head = part_scene.instantiate()
	head.connect("arrived", on_move)
	add_child(head)
	
	for i in range(starting_parts - 1):
		head.grow()
	

func _ready():
	queue = TimedInputQueue.new()
	spawn_snake()
	head.move(direction)

func on_move():
	var input = queue.pop()
	if input != "":
		match input:
			"left":
				direction = Vector2(-1, 0)
			"right":
				direction = Vector2(1, 0)
			"up":
				direction = Vector2(0, -1)
			"down":
				direction = Vector2(0, 1)
	
	head.move(direction)

func _input(event):
	if event is InputEventKey:
		event = event as InputEventKey
		if event.pressed:
			match event.as_text_physical_keycode():
				"A":
					queue.push("left")
				"D":
					queue.push("right")
				"W":
					queue.push("up")
				"S":
					queue.push("down")
