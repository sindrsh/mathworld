extends Area2D

var value : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.position += Vector2(0, 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
