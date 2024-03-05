extends Node2D

# Wherever this object is will be the initial "root" of the snake
var part_scene = preload("res://components/snake_part/snake_part.tscn")
var queue: TimedInputQueue
var head: SnakePart
var direction: Vector2 = Vector2(1, 0)

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
	print("reached position")
	queue.printQueue()
	var input = queue.pop()
	if input != "":
		match input:
			"ui_left":
				direction = Vector2(-1, 0)
			"ui_right":
				direction = Vector2(1, 0)
			"ui_up":
				direction = Vector2(0, -1)
			"ui_down":
				direction = Vector2(0, 1)
	
	head.move(direction)

func _input(event):
	if event is InputEventAction:
		event = event as InputEventAction
		var acceptable_actions = ["ui_left", "ui_right", "ui_down", "ui_up"]
		
		if event.action in acceptable_actions:
			print("pushing ", event.action)
			queue.push(event.action)
