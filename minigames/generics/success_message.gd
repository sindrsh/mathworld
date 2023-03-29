extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($ToMenuButton.connect("pressed", _go_to_menu) == 0)
	$Background.size = get_viewport_rect().size
	$ToMenuButton.position = get_viewport_rect().size/2
	$Label.position = get_viewport_rect().size/2 - Vector2(0,100)


func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://start_menu.tscn") != OK:
		print("Could not change scene")

