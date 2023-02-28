extends Button

var scene : String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene)
# Called when the node enters the scene tree for the first time.
func _ready():
	assert(connect("pressed", _on_pressed) == 0)
