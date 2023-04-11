extends HBoxContainer

var minigame_choice : Button = preload("res://mini_game_choice.tscn").instantiate()
var dir_body : String = "res://minigames/mul/times_table/Times"
var numbers : PackedStringArray = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]

# Called when the node enters the scene tree for the first time.
func _ready():
	minigame_choice.custom_minimum_size = Vector2(100,50)
	for i in range(numbers.size()):
		var game_button = minigame_choice.duplicate()
		game_button.text = str(i)
		game_button.scene_path = dir_body + numbers[i] + ".tscn"
		add_child(game_button)
