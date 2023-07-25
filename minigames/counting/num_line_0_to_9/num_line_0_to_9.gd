extends MiniGame

var bar_length : int


# Called when the node enters the scene tree for the first time.
func _ready():
	bar_length = $Bar.texture.get_width()
	for i in range(9):
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = Vector2(200 + i*bar_length, 100)
		bar.show()
		add_child(bar)
		await get_tree().create_timer(0.5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
