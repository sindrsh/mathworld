extends CharacterBody2D

signal bubble_pressed(_name : String)
 
var speed : int = 100
var one : Texture = preload("res://minigames/generics/assets/one.svg")
var number : float
var representation : int

var representation2 : Array = [
	preload("res://minigames/generics/assets/1b.svg"),
	preload("res://minigames/generics/assets/2b.svg"),
	preload("res://minigames/generics/assets/3b.svg"),
	preload("res://minigames/generics/assets/4b.svg"),
	preload("res://minigames/generics/assets/5b.svg"),
	preload("res://minigames/generics/assets/6b.svg"),
	preload("res://minigames/generics/assets/7b.svg"),
	preload("res://minigames/generics/assets/8b.svg"),	
	preload("res://minigames/generics/assets/9b.svg"),
]

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

	

