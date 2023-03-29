extends Node2D
class_name MiniGame

var menu_button = Button.new()
var restart_button = Button.new()

func _ready() -> void:
	assert(menu_button.connect("pressed", _go_to_menu) == 0)
	assert(restart_button.connect("pressed", _restart_game) == 0)
	
	menu_button.position = Vector2(get_viewport_rect().size.x-100, 50)
	menu_button.text = "MENU"
	
	restart_button.position = menu_button.position - Vector2(100,0)
	restart_button.text = "RESTART"
	
	add_child(menu_button)
	add_child(restart_button)
	_add_specifics()

func _add_specifics() -> void:
	pass

func _restart_game() -> void:
	get_tree().reload_current_scene()

func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://start_menu.tscn") != OK:
		print("Could not change scene")

