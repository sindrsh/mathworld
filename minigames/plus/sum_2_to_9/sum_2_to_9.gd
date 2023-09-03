extends MiniGame

var group = preload("res://minigames/generics/puzzles/number_board/group.tscn").instantiate()
const Number = preload("res://minigames/generics/puzzles/number_board/number.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_group = group.duplicate()
	new_group.position = Vector2(200, 600)
	new_group.arrange(Vector2(200, 200))
	var number := Number.new(1)
	add_child(new_group)
	add_child(number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
