extends Area2D
class_name SnakePart


@export var speed: float = 512  # px / s 
@onready var player: AnimationPlayer = get_node("AnimationPlayer")
var _next_pos: Vector2 = Vector2(0, 0)
signal collided
signal at_point
var _faded_in = false


func goto(pos: Vector2):
	_next_pos = pos

func teleport():
	if !_faded_in:
		player.play("fade_in")
		_faded_in = true
	position = _next_pos


func _physics_process(delta):
	if position.distance_to(_next_pos) < speed * delta:
		position = _next_pos
		emit_signal("at_point")
	
	position += (_next_pos - position).normalized() * speed * delta
	return

func _on_area_entered(_area):
	emit_signal("collided")


func play_die_animation():
	player.play("die")
