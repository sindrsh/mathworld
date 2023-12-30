extends Button

@export var path : String

# Called when the node enters the scene tree for the first time.
func _ready():
	custom_minimum_size = Vector2(80, 50)


func _pressed():
	if get_tree().change_scene_to_file(path) != OK:
		print("Minigame not found")
