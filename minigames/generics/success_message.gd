extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($"%ToMenuButton".connect("pressed", _go_to_menu) == 0)
	assert($"%RestartButton".connect("pressed", _restart) == 0)
	assert($"%CountingWorldButton".pressed.connect(_go_to_counting_world) == 0)

func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://start_menu.tscn") != OK:
		print("Could not change scene")

func _restart() -> void:
	if get_tree().change_scene_to_file(GlobalVariables.current_game_path) != OK:
		print("Could not change scene")

func _go_to_counting_world():
	if get_tree().change_scene_to_file("res://world/counting_world.tscn") != OK:
		print("Could not change scene")
