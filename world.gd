extends Node2D

var size_vec : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	size_vec = $TileMap.tile_set.tile_size
	$TileMap/PlayerCharachter.position = 0.5*size_vec
	var target = Vector2(2.0*size_vec.x, 4.0*size_vec.y)
	$TileMap/PlayerCharachter.target = target
	$TileMap/PlayerCharachter.moving = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
