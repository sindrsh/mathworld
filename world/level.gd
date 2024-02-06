extends Sprite2D
class_name LevelIcon

# has to be a Sprite2D since Control nodes work weirdly with outlines

@onready var outline_material = preload("res://assets/materials/counting_world_button_outline.tres")
@export var scene: PackedScene 

func _on_clickable_on_hover_start():
	material = outline_material

func _on_clickable_on_hover_stop():
	material = null


func _on_clickable_on_click():
	get_tree().change_scene_to_packed(scene)
