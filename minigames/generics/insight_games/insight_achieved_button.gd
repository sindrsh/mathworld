extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	get_parent()._end_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
