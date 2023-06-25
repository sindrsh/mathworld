extends Area2D


const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")

var place: int
var movable_shape : TextureButton
var area = CollisionShape2D.new()
var original_position : Vector2


func _init(txture : Texture2D):
	movable_shape = MovableShape.new()
	movable_shape.set_txture_normal(txture)
	area.shape = RectangleShape2D.new()
	area.shape.size = txture.get_size()
	add_child(movable_shape)
	add_child(area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if movable_shape.active:
		position.y = get_global_mouse_position().y + movable_shape.mouse_offset.y + movable_shape.texture_size_div2.y
