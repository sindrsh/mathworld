extends Node2D


@onready var effect_scene = preload("res://singletons/dissolver/particleEffect/dissolve_effect.tscn")


func dissolve(pos: Vector2, size: Vector2):
	var instance: CPUParticles2D = effect_scene.instantiate()
	add_child(instance)
	instance.position = pos
	instance.emission_rect_extents = size
	print(pos, size)
