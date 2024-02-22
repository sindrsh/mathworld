extends Sprite2D
class_name LevelIcon

# has to be a Sprite2D since Control nodes work weirdly with outlines

@export var scene: PackedScene 
@export var minigame: String
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var collison_shape: Node2D = get_node("CollisionShape2D")
@onready var clickable: Node2D = get_node("Clickable")

func _ready():
	material = material.duplicate()  # required or it doesn't work
	material.set_shader_parameter("line_color", Color(0, 0, 0, 0))
	
	# Getting an error here? It's probably because all "Level" nodes need a CollisionShape2D
	clickable.add_child(collison_shape.duplicate())
	collison_shape.queue_free()

func _on_clickable_on_hover_start():
	animation_player.play("hover")

func _on_clickable_on_hover_stop():
	animation_player.play_backwards("hover")

func _on_clickable_on_click():
	get_tree().change_scene_to_packed(scene)

func play_effect():
	animation_player.play("scale_in")
