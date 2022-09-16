extends "res://MenuButton.gd"

func _on_pressed():
	if get_tree().change_scene("res://VideoMenu.tscn") != OK:
		print("Node 'VideoMenu not found'")
# Called when the node enters the scene tree for the first time.
func _ready():
	font.size = 28
	assert(connect("pressed", self, "_on_pressed") == 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
