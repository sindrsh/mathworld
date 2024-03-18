extends Area2D
class_name SnakePart

var front: SnakePart  # if this is null, it means that this is the head of the snake. Really wish Godot had type unions.
var back: SnakePart

var next_position: Vector2
var _last_position: Vector2
const SPEED = 512  # px/s
const CELL_SIZE = 64  # px

@onready var _animation_player = get_node("AnimationPlayer")
var snake_scene = preload("res://components/snake_part/snake_part.tscn")
var grace_period = true
var start_position: Vector2 = Vector2(-1, -1)

signal ate_fruit(number: int)
signal arrived()

func _init():
	_last_position = position + Vector2(CELL_SIZE, 0)

func _ready():
	$Timer.start()
	if start_position != Vector2(-1, -1):
		print("going to start position", start_position)
		position = start_position
		next_position = front.position

func _physics_process(delta):
	if position.distance_to(next_position) < SPEED * delta:
		position = next_position
		emit_signal("arrived")
	else:
		position += (next_position - position).normalized() * SPEED * delta


func move(direction: Vector2):
	position = next_position
	_last_position = next_position
	next_position = position + direction * CELL_SIZE
	
	if back != null:
		back.move((position - back.next_position).normalized())

func grow():
	if back != null:
		back.grow()
		return
	# add a new part behind me
	print("growing")
	var snake: SnakePart = snake_scene.instantiate()
	
	snake.front = self 
	back = snake
	var direction = (next_position - position).normalized().rotated(PI)
	snake.start_position = position + CELL_SIZE * direction
	
	var parent = get_parent()
	if parent != null:
		parent.add_child(snake)


func _on_area_entered(area: Area2D):
	print("collided")
	if area.get_collision_layer_value(1) == true:
		collided()
		get_parent().health = 0
	if area.get_collision_layer_value(2) == true:
		area = area as NumberFruit
		area.eat()
		emit_signal("ate_fruit", area.number)
		grow()

# collided travels up the snake. The head of the snake then initiates the suicide
func collided():
	if front == null:
		die()
	else:
		front.collided()

# kill myself and everyone behind me
func die():
	if back != null:
		back.die()
	
	_animation_player.play("die")



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()


func _on_timer_timeout():
	grace_period = false
