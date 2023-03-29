extends Button

@export var scene : String

func _ready():
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene)
