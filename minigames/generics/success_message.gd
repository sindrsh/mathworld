extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($"%ToMenuButton".connect("pressed", _go_to_menu) == 0)
	assert($"%RestartButton".connect("pressed", _restart) == 0)


func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://start_menu.tscn") != OK:
		print("Could not change scene")

func _restart() -> void:
	get_tree().reload_current_scene()
