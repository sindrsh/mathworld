extends Control

class_name MiniGame

enum {AMOUNT, NUMBER_LINE}

var world_part : String
var id : String
var minigame_type : int

var game_index : int
var MenuBarScene : PackedScene = load("res://minigames/generics/MenuBar.tscn")
var menu_bar = MenuBarScene.instantiate()
var cheat_button := Button.new()

func _ready():
#	size = Vector2(1920, 1080)
	
	add_child(menu_bar);
	
	_add_generics()
	_add_specifics()
	
	
	if GlobalVariables.world_parts.has(world_part):
		game_index = GlobalVariables.get_game_index(GlobalVariables.world_parts[world_part][minigame_type], id)
	cheat_button.text = "cheat"
	cheat_button.position = Vector2(1800, 1000)
	cheat_button.pressed.connect(_end_game)
	add_child(cheat_button)
	
func _add_generics() -> void:
	pass


func _add_specifics() -> void:
	pass


func _game_completed() -> void:
	if GlobalVariables.world_parts.has(world_part):
		var game_array = GlobalVariables.world_parts[world_part][minigame_type][game_index]
		game_array["status"] = GlobalVariables.COMPLETED
		if id not in PlayerVariables.save_dict["minigames"][world_part]:
			PlayerVariables.save_dict["minigames"][world_part].push_back(id) 
		var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
		var json_string = JSON.stringify(PlayerVariables.save_dict)
		save_game.store_line(json_string)
	
	
func _end_game_condition() -> bool:
	return false
	

func _end_game_message():
	return "Mini game completed!"
	
	
func _end_game() -> void:
	_game_completed()
	var message = load("res://minigames/generics/SuccessMessage.tscn").instantiate()
	message.get_node("%Label").text = _end_game_message()
	add_child(message)	
