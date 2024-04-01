extends TextureButton

@export var minigame : String
@export var world_part : String

@onready var outline_material = preload("res://assets/materials/counting_world_button_outline.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", apply_outline)
	connect("mouse_exited", remove_outline)
	

func _pressed():
	get_tree().change_scene_to_file(
		GlobalVariables.get_typeless_minigame_path(world_part, minigame) + ".tscn"
		)

func apply_outline():
	material = outline_material

func remove_outline():
	material = null
