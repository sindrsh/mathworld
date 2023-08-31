extends Node2D

var development_board : Node2D = preload("res://world/development_board.tscn").instantiate()

var amount_minigames : Array
var number_line_minigames : Array
var developments := {
	"amount_insights": 0,
 	"amount_calculations": 0,
 	"number_line_insights" : 0,
	"number_line_calculations" : 0,
}

var development_board_clikced : bool
var data

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($DevelopmentBoard.pressed.connect(_on_development_button_pressed) == 0)
	
	amount_minigames = [
		$Amount0To9, 
		$NumberMatch, 
		$NumberCatch, 
		$Amount0To50, 
		$FallingAmounts0To999,
	]
	number_line_minigames = [
		$NumLine0To9, 
		$FallingNumbers0To9, 
		$NumberBridge0To9,	
		$FallingDecimals0To2,
	]
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
		print("I should be doing something")
		
	return false

func _show_minigames() -> void:
	for minigames in [amount_minigames, number_line_minigames]:
		minigames[0].show()
		for i in range(1, minigames.size()):
			if _is_completed(minigames[i-1]):
				minigames[i].show()
		
		for i in range(0, minigames.size()):
			_do_minigame_effect(minigames[i])

func _update_development_status(minigames : Array, minigames_array : Array, insights : String, calculations : String) -> void:
	for node in minigames:
		var id : String = node.get("minigame")
		var minigame_dict : Dictionary = GlobalVariables.get_game_dictionary(minigames_array, id)
		if minigame_dict["status"] == GlobalVariables.COMPLETED:
			if minigame_dict["branch"] == GlobalVariables.INSIGHT:
				developments[insights] += 1
			if minigame_dict["branch"] == GlobalVariables.CALCULATION:
				developments[calculations] += 1	

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
	
	for i in range(developments["amount_calculations"]):
		development_board.get_node("VBoxContainer/AmountsCalculations/PurpleBarsContainer/" + "PurpleBar" + str(i+1)).show()
		
	for i in range(developments["number_line_calculations"]):
		development_board.get_node("VBoxContainer/NumberLineCalculations/PurpleBarsContainer/" + "PurpleBar" + str(i+1)).show()
	
	development_board.show()			
		
func _on_development_button_pressed() -> void:
	development_board_clikced = not development_board_clikced
	if development_board_clikced:
		_show_development()
	else:
		_show_map()
