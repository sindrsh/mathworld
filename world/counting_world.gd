extends Node2D

var development_board : Node2D = preload("res://world/development_board.tscn").instantiate()

var effect_scene = preload("res://world/effect.tscn")

var amount_minigames : Array
var number_line_minigames : Array
var developments := {
	"amount_insights": 0,
 	"amount_calculations": [],
 	"number_line_insights" : 0,
	"number_line_calculations" : [],
}

var development_board_clikced : bool
var data

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($DevelopmentBoard.pressed.connect(_on_development_button_pressed) == 0)
	assert($ShowAllGames.pressed.connect(_show_all_games) == 0)
	assert($Button.pressed.connect(_on_smartboard_pressed) == 0)
	
	amount_minigames = [
		$Amount0To9, 
		$NumberMatch, 
		$NumberCatch, 
		$Amount0To50, 
		$MakeAmounts1To50,
		$Snake1To50,
		$Amount50To999,
		$MakeAmounts1To999,
	]
	number_line_minigames = [
		$NumLine0To9, 
		$FallingNumbers0To9, 
		$NumberBridge0To9,	
		$NumberLine10To100,
		$RunHill0To100
	]
	
	$Snake1To50.minigame = "snake_1_to_50"
	$Snake1To50.path = "res://minigames/generics/snake_minigame/snake_minigame.tscn"
	$MakeAmounts1To50.minigame = "make_amounts_1_to_50"
	$MakeAmounts1To50.path = "res://minigames/counting/make_amounts_1_to_50/make_amounts_1_to_50.tscn"
	$RunHill0To100.minigame = "run_hill"
	$RunHill0To100.path = "res://minigames/generics/run_hill/run_hill.tscn"
	
#	var save_game := FileAccess.open("user://savegame.save", FileAccess.READ)
#	var json := JSON.new()
	
	FileAccess.open("user://savegame.save", FileAccess.WRITE).store_line("")
#	data = json.parse_string(save_game.get_as_text())
		
	if data:
		PlayerVariables.save_dict = data
	
	_update_development_status(amount_minigames, GlobalVariables.count_amount_minigames, "amount_insights", "amount_calculations")
	_update_development_status(number_line_minigames, GlobalVariables.count_number_line_minigames, "number_line_insights", "number_line_calculations")
	development_board.position.x = 635
	development_board.hide()
	add_child(development_board)	
	_show_map()

func _is_completed(node : TextureButton) -> bool:
	if node.get("minigame"):
		return node.get("minigame") in PlayerVariables.save_dict["minigames"]["counting"]
	return false

func _do_minigame_effect(node: TextureButton) -> bool:
	if node.get("minigame") == PlayerVariables.save_dict["minigames"]["lastCompletedMinigame"]:
		var instance = effect_scene.instantiate()
		node.add_child(instance)
		
	return false

func _show_minigames() -> void:
	if not PlayerVariables.show_all_games:
		for minigames in [amount_minigames, number_line_minigames]:
			minigames[0].show()
			for i in range(1, minigames.size()):
				if _is_completed(minigames[i-1]):
					minigames[i].show()
			
			for i in range(0, minigames.size()):
				_do_minigame_effect(minigames[i])
	else:
		for minigames in [amount_minigames, number_line_minigames]:
			for i in range(minigames.size()):
				minigames[i].show()


func _update_development_status(minigames : Array, minigames_array : Array, insights : String, calculations : String) -> void:
	for node in minigames:
		var id : String = node.get("minigame")
		var minigame_dict : Dictionary = GlobalVariables.get_game_dictionary(minigames_array, id)
		if minigame_dict["status"] == GlobalVariables.COMPLETED:
			if minigame_dict["branch"] == GlobalVariables.INSIGHT:
				developments[insights] += 1
			if minigame_dict["branch"] == GlobalVariables.CALCULATION:
				developments[calculations].append(minigame_dict["score"])

func _show_map() -> void:
	for node in get_children():
		node.show()
		node = node as TextureButton
		if node:
			node.hide()
	development_board.hide()
	$DevelopmentBoard.show()
	_show_minigames()
	
	
func _show_development() -> void:
	for node in get_children():
		node.hide()
	
	$DevelopmentBoard.show()
	$MenuBar.show()
	
	for i in range(developments["amount_insights"]):
		development_board.get_node("VBoxContainer/AmountsInsights/PurpleBarsContainer/" + "PurpleBar" + str(i+1)).show()
	
	var ratings : Array = development_board.get_node("VBoxContainer/AmountsCalculations/PurpleBarsContainer/").get_children()
	for i in range(developments["amount_calculations"].size()):
		var rating = ratings[i]
		rating.get_node("RatingIndicator").frame = developments["amount_calculations"][i]
		rating.show()
	
	development_board.show()			
		
func _on_development_button_pressed() -> void:
	development_board_clikced = not development_board_clikced
	if development_board_clikced:
		_show_development()
	else:
		_show_map()
	
func _show_all_games() -> void:
	PlayerVariables.show_all_games = true
	_show_minigames()


func _on_smartboard_pressed() -> void:
	if get_tree().change_scene_to_file("res://smartboard.tscn") != OK:
		print("Minigame not found")
