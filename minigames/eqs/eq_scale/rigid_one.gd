extends RigidBody2D
signal shape_pressed(_name)

const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")

var texture_size = Vector2(0,0)
var movable_shape := MovableShape.new()
var previous_position : Vector2
var value : float

var new_pos : Vector2	

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
	collision_layer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _init():
	gravity_scale = 0

func _process(_delta):
	if position.y < -500 or position.y > get_viewport_rect().size.y:
		queue_free()
	if movable_shape.active:
		collision_layer = 0
		new_pos = get_global_mouse_position() + movable_shape.mouse_offset + texture_size/2


func _on_shape_pressed() -> void:
	collision_layer = 1
	gravity_scale = value/abs(value)*1
	emit_signal("shape_pressed", name)		
	
	
func _integrate_forces(state):
	if movable_shape.active:
		position = new_pos
		state.transform = Transform2D(0, position)
