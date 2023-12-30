extends Control

class_name MiniGame

enum {AMOUNT, NUMBER_LINE}

# every child must set these three variables
# in the _add_specifics function
var world_part : String
var id : String
var minigame_type : int

var game_index : int
var MenuBarScene : PackedScene = load("res://minigames/generics/MenuBar.tscn")
var status_bar_scene : PackedScene = load("res://minigames/generics/status_bar.tscn")
var menu_bar : Node2D = MenuBarScene.instantiate()
var cheat_button := Button.new()
var status_bar : AnimatedSprite2D
var music_player := AudioStreamPlayer2D.new()


func _ready():
	
	assert(menu_bar.get_node("HBoxContainer/MusicButton").toggled.connect(_on_music_button_toggled) == 0)
	GlobalVariables.current_game_path = get_scene_file_path()
	
	_add_generics()
	_add_specifics()
	
	add_child(menu_bar);
	add_child(music_player)
	music_player.playing = true
	
	
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
		var game_dict: Dictionary = GlobalVariables.world_parts[world_part][minigame_type][game_index]
		game_dict["status"] = GlobalVariables.COMPLETED
		if id not in PlayerVariables.save_dict["minigames"][world_part]:
			
			PlayerVariables.save_dict["minigames"][world_part].push_back(id) 
			PlayerVariables.save_dict["minigames"]["lastCompletedMinigame"] = id
			PlayerVariables.save_dict["minigames"]["effectPlayed"] = false
		var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
		var json_string = JSON.stringify(PlayerVariables.save_dict)
		save_game.store_line(json_string)
		if status_bar and game_dict.has("score"):
			game_dict["score"] = status_bar.frame - 1
			
			
	
func _add_status_bar() -> void:
	status_bar = status_bar_scene.instantiate()
	status_bar.position = Vector2(1800, 500)
	add_child(status_bar)
	
func _end_game_condition() -> bool:
	return false
	

func _end_game_message():
	return "Mini game completed!"


func _stop_game() -> void:
	call_deferred("set_physics_process", false)
		
		
func _end_game() -> void:
	_stop_game()
	_game_completed()
	if get_tree().change_scene_to_file("res://minigames/generics/SuccessMessage.tscn") != OK:
		print("Failed changing scene")

func _end_game_with_failure():
	_stop_game()
	if get_tree().change_scene_to_file("res://minigames/generics/FailureMessage.tscn") != OK:
		print("Failed changing scene")

func _on_music_button_toggled(_button_pressed : bool) -> void:
	music_player.playing = not _button_pressed
