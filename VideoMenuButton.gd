extends "res://MenuButton.gd"

var scene
func _on_pressed():
	if get_tree().change_scene(scene) != OK:
		print("Change of scene failed.")
# Called when the node enters the scene tree for the first time.
func _ready():
	font.size = 32
	rect_position = Vector2(100,100)
	assert(connect("pressed", self, "_on_pressed") == 0)
