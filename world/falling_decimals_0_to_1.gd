extends TextureButton

var minigame := "falling_decimals_0_to_2"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _pressed():
	get_tree().change_scene_to_file(
		GlobalVariables.get_typeless_minigame_path("counting", minigame) + ".tscn"
		)
