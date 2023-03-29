extends Node2D
class_name MiniGame

var hbox := HBoxContainer.new()
var margin_box := MarginContainer.new()

var menu_button := Button.new()
var restart_button := Button.new()

func _ready() -> void:
	assert(menu_button.connect("pressed", _go_to_menu) == 0)
	assert(restart_button.connect("pressed", _restart_game) == 0)
	
	menu_button.text = "MENU"
	restart_button.text = "RESTART"

	hbox.add_child(menu_button)
	hbox.add_child(restart_button)

	hbox.set("theme_override_constants/separation", 20)
	hbox.set("size_flags_horizontal", Control.SIZE_SHRINK_END)
	hbox.set("size_flags_vertical", Control.SIZE_SHRINK_BEGIN)
	
	var margin = 50
	margin_box.size = get_viewport_rect().size
	margin_box.set("theme_override_constants/margin_left", margin)
	margin_box.set("theme_override_constants/margin_right", margin)
	margin_box.set("theme_override_constants/margin_top", margin)
	margin_box.set("theme_override_constants/margin_bottom", margin)
	
	margin_box.add_child(hbox)
	add_child(margin_box)
	
	_add_specifics()

func _add_specifics() -> void:
	pass

func _restart_game() -> void:
	get_tree().reload_current_scene()

func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://start_menu.tscn") != OK:
		print("Could not change scene")

