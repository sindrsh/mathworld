extends Control

class_name MiniGame

var MenuBarScene : PackedScene = load("res://minigames/generics/MenuBar.tscn")
var menu_bar = MenuBarScene.instantiate()

func _ready():
#	size = Vector2(1920, 1080)
	
	add_child(menu_bar);
	
	_add_generics()
	_add_specifics()


func _add_generics() -> void:
	pass


func _add_specifics() -> void:
	pass
