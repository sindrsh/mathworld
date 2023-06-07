extends Node2D

signal button_released(_name)

const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")

var movable_shape : MovableShape = MovableShape.new()
var factors : PackedFloat32Array
var start_pos : Vector2
var identity : Array
var texture_size_div_2 : Vector2
var original_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(movable_shape.released.connect(_on_released) == 0)
	add_child(movable_shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if movable_shape.active:
		position = get_global_mouse_position() + movable_shape.mouse_offset + texture_size_div_2


func _on_released():
	emit_signal("button_released", name)
	
