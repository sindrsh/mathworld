extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _pressed():
	get_tree().change_scene_to_file("res://minigames/counting/matching_0_to_9/Match0To9.tscn")	
