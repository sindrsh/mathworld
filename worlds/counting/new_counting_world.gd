extends Control

@onready var amount_games = [$Building, $Building8, $Building9, $Building2, $Building11, $Building13, $Building3, $Building10]
@onready var num_line_games = [$Building4, $Building12, $Building5, $Building6, $Building7]

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_game()
	_show_buildings(num_line_games)
	_show_buildings(amount_games)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _show_buildings(buildings: Array) -> void:
	for i in range(buildings.size() - 1):
		var id: String = buildings[i].minigame_path.split("/")[-1].trim_suffix(".tscn")
		if id in GlobalVariables.completed_games:
			buildings[i+1].show()
		

func _load_game() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var save_data: String = save_file.get_as_text()
	var json := JSON.new()
	var error = json.parse(save_data)
	var data = {}
	if error == OK:
		data = json.data
	if not data:
		return
	for id in data:
		GlobalVariables.completed_games.push_back(id)
		var game_dict: Dictionary = GlobalVariables.get_game_dictionary(id)
		game_dict["score"] = data[id]
