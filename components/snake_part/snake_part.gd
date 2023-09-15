extends Area2D
class_name SnakePart


@export var speed: float = 512  # px / s 
var _next_pos: Vector2 = Vector2(0, 0)
signal collided
signal at_point


func goto(pos: Vector2):
	_next_pos = pos


func teleport():
	position = _next_pos


func _physics_process(delta):
	if position.distance_to(_next_pos) < speed * delta:
		position = _next_pos
		emit_signal("at_point")
	
	position += (_next_pos - position).normalized() * speed * delta


func _on_area_entered(area):
	emit_signal("collided")

