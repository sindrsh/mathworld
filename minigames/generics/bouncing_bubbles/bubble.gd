extends CharacterBody2D

signal bubble_pressed(_name : String)

var speed : int = 300
var int_value : Array
var float_value : float
var representation : int


func _ready():
	assert($BubbleButton.connect("pressed", _on_pressed) == 0)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())


func _on_pressed() -> void:
	emit_signal("bubble_pressed", name)
		
		
func start(_position, _direction):
	position = _position
	velocity = Vector2(speed, 0).rotated(_direction)

	

