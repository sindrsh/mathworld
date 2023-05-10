extends CharacterBody2D


signal shape_pressed(_name)

const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")

var texture_size = Vector2(0,0)
var movable_shape := MovableShape.new()
var previous_position : Vector2
var value : float
var gravity : float = 0.0

var button_texture : Texture2D:
	set(txture):
		var collision_shape := CollisionShape2D.new()
		collision_shape.shape = CircleShape2D.new()
		collision_shape.shape.radius = txture.get_size().y/2
		button_texture = txture
		movable_shape.texture_normal = txture
		movable_shape.position = -txture.get_size()/2
		texture_size = txture.get_size()
		add_child(collision_shape)
		add_child(movable_shape)
		

func _ready():
	assert(movable_shape.pressed.connect(_on_shape_pressed) == 0)
	previous_position = position
	collision_layer = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		queue_free()
	if movable_shape.active:
		collision_layer = 0
		position = get_global_mouse_position() + movable_shape.mouse_offset + texture_size/2


func _on_shape_pressed() -> void:
	gravity = value/abs(value)*ProjectSettings.get_setting("physics/2d/default_gravity")
	print(gravity)
	collision_layer = 1
	emit_signal("shape_pressed", name)		




func _physics_process(delta):
	if not movable_shape.active:
		velocity.y += gravity * delta
		
		
	move_and_slide()
