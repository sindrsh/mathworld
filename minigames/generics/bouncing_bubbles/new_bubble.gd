extends CharacterBody2D

signal bubble_pressed(_name : String)

var speed : int = 200
var int_value : Array
var float_value : float
var representation : int
var collision_shape := CollisionShape2D.new()
var button := TextureButton.new()
var sprite := AnimatedSprite2D.new()

func _init():
	button.texture_normal = load("uid://by025kjoj5smx")
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 50
	sprite.sprite_frames = SpriteFrames.new()
	button.position = -Vector2(button.texture_normal.get_width(), button.texture_normal.get_height())/2

func _ready():
	assert(button.connect("pressed", _on_pressed) == 0)
	
	add_child(collision_shape)
	add_child(button)
	add_child(sprite)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())


func _on_pressed() -> void:
	emit_signal("bubble_pressed", name)
		
		
func start(_position, _direction):
	position = _position
	velocity = Vector2(speed, 0).rotated(_direction)

	

