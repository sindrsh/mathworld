extends CharacterBody2D

signal bubble_pressed(_name : String)

var speed : int = 100
var int_value : Array
var float_value : float
var representation : int
var collision_shape := CollisionShape2D.new()
var button := TextureButton.new()
var sprite := AnimatedSprite2D.new()

var background_a : Array

func _init():
	background_a = [
		preload("res://minigames/generics/assets/snooker_numbers/zero.svg"),
		preload("res://minigames/generics/assets/snooker_numbers/one.png"),
		preload("res://minigames/generics/assets/snooker_numbers/two.png"),
		preload("res://minigames/generics/assets/snooker_numbers/three.png"),
		preload("res://minigames/generics/assets/snooker_numbers/four.png"),
		preload("res://minigames/generics/assets/snooker_numbers/five.png"),
		preload("res://minigames/generics/assets/snooker_numbers/six.png"),
		preload("res://minigames/generics/assets/snooker_numbers/seven.png"),
		preload("res://minigames/generics/assets/snooker_numbers/eight.png"),	
		preload("res://minigames/generics/assets/snooker_numbers/nine.png"),
	]
	
	button.texture_normal = load("res://minigames/generics/assets/circle_white.svg")
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
		
		
func set_frames(frame0path : String = '', frame1path : String = '', 
		configuration1 : bool = true) -> void:
	
	if frame0path == '' and frame1path == '':
		if configuration1:
			frame0path = "res://minigames/generics/assets/circle_white.svg"
			frame1path = "res://minigames/generics/assets/circle_purple.svg"
		else: 
			frame0path = "res://minigames/generics/assets/circle_yellow.svg"
			frame1path = "res://minigames/generics/assets/circle_purple.svg"
				
	sprite.sprite_frames.add_frame(
			"default",
			background_a[randi_range(0, 8)]
			#load(frame0path)
	)
	sprite.sprite_frames.add_frame(
			"default",
			load(frame1path)
	)	
		
func start(_position, _direction):
	if (representation == 1):
		button.texture_normal = background_a[int_value[0]]
	position = _position
	velocity = Vector2(speed, 0).rotated(_direction)


func on_kill():
	print("I am dead")
