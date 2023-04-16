extends CharacterBody2D

signal bubble_pressed(_name : String)

var gravity = 50.0
var int_value : Array
var float_value : float
var collision_shape := CollisionShape2D.new()
var button := TextureButton.new()
var sprite := AnimatedSprite2D.new()

func _init():
	button.texture_normal = load("res://minigames/generics/assets/circle_arc.svg")
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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if position.y > get_viewport_rect().size.y:
		queue_free()
	
	move_and_slide()

func _on_pressed() -> void:
	emit_signal("bubble_pressed", name)
