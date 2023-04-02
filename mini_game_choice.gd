extends Button

@export var scene_path : String

func _ready():
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_path)

