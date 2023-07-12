extends CharacterBody2D

signal bullet_pressed(_name : String)
signal target_reached(_name : String)

var int_value : Array
var float_value : float
var collision_shape := CollisionShape2D.new()
var button := TextureButton.new()
var sprite := AnimatedSprite2D.new()
var target_node : CharacterBody2D
var speed := 1500.0
var equals_bubble := false

func _init():
	button.texture_normal = load("res://minigames/generics/assets/circle_arc.svg")
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 50
	sprite.sprite_frames = SpriteFrames.new()
	button.position = -Vector2(button.texture_normal.get_width(), button.texture_normal.get_height())/2
	collision_layer = 2

func _ready():
	assert(button.connect("pressed", _on_pressed) == 0)
	
	sprite.sprite_frames.add_frame(
			"default",
			load("res://minigames/generics/assets/circle_white.svg")
	)
	sprite.sprite_frames.add_frame(
			"default",
			load("res://minigames/generics/assets/circle_purple.svg")
	)
	
	add_child(collision_shape)
	add_child(button)
	add_child(sprite)


func _physics_process(delta):
	if target_node:
		if move_and_collide(position.direction_to(target_node.position) * speed * delta):
			emit_signal("target_reached", name)


func _on_pressed() -> void:
	emit_signal("bullet_pressed", name)

