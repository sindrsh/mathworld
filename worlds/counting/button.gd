extends Button

@export var file_path : String

func _pressed() -> void:
	get_tree().change_scene_to_file(file_path)
	
