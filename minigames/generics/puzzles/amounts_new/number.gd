extends Sprite2D

var speed := 20.0
var moving:= false
var target : Vector2:
	set(_target):
		target = _target
		moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		_move()


func _move() -> void:
	if position.distance_to(target) > speed:
		position += speed*position.direction_to(target)
	else:
		position = target
		moving = true
