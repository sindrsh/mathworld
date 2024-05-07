extends AnimatedSprite2D

signal target_reached 

var target := Vector2(950, 500)
var moving := false
var speed := 20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		if position.distance_to(target) > speed:
			position += position.direction_to(target)*speed
		else:
			position = target
			moving = false
			target_reached.emit()
