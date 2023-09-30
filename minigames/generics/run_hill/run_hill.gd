extends MiniGame

var lane : Node2D = preload("res://minigames/generics/run_hill/lane.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _add_specifics():
	add_child(lane)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lane.position.x -= 20*delta
