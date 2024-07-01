extends Area2D


const MovableShape = preload("res://minigames/generics/puzzles/movable_shape.gd")

var place: int
var movable_shape : TextureButton
var area = CollisionShape2D.new()
var original_position : Vector2
var y_limit : float
var sprite := Sprite2D.new()


func _init(txture : Texture2D):
	movable_shape = MovableShape.new()
	movable_shape.set_txture_normal(txture)
	movable_shape.scale_and_modulate(Vector2(1.5, 1.5))
	area.shape = RectangleShape2D.new()
	area.shape.size = txture.get_size()
	sprite.texture = txture
	add_child(movable_shape)
	add_child(area)
	add_child(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if movable_shape.active: 
		var temp_y = get_global_mouse_position().y + movable_shape.mouse_offset.y + movable_shape.texture_size_div2.y
		if temp_y > y_limit:
			position.y = temp_y
		else:
			position.y = y_limit
