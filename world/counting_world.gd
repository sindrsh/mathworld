extends Node2D

var amount_minigames : Array
var data
# Called when the node enters the scene tree for the first time.
func _ready():
	amount_minigames = [$Amounts_0_to_9, $NumberMatch, $NumberCatch,]
	var save_game := FileAccess.open("user://savegame.save", FileAccess.READ)
	var json := JSON.new()

	
	FileAccess.open("user://savegame.save", FileAccess.WRITE).store_line("")
#	data = json.parse_string(save_game.get_as_text())
		
	if data:
		PlayerVariables.save_dict = data
	
	for node in get_children():
		node = node as TextureButton
		if node:
			node.hide()
	
	amount_minigames[0].show()
	
	for i in range(1, amount_minigames.size()):
		if _is_completed(amount_minigames[i-1]):
			amount_minigames[i].show()

func _is_completed(node : TextureButton) -> bool:
	if node.get("minigame"):
		return node.get("minigame") in PlayerVariables.save_dict["minigames"]["counting"]
	return false
