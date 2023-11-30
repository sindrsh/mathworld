extends Area2D

const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")
var movable_shape := MovableShape.new()
var value : int 

# Called when the node enters the scene tree for the first time.
func _ready():
	movable_shape.set_txture_normal($Numbers.sprite_frames.get_frame_texture("default", 0))
	add_child(movable_shape)
	$CollisionShape2D.shape.size = movable_shape.texture_normal.get_size()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if movable_shape.active:
		position = get_global_mouse_position() + movable_shape.mouse_offset + movable_shape.texture_size_div2
