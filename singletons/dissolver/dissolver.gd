extends Node2D


@onready var effect_scene = preload("res://singletons/dissolver/particleEffect/dissolve_effect.tscn")


func dissolve(pos: Vector2, size: Vector2, amount: int = 1024):
	var instance: CPUParticles2D = effect_scene.instantiate()
	add_child(instance)
	instance.position = pos
	instance.emission_rect_extents = size
	instance.amount = amount
	instance.emitting = true
	print(pos, size)


func dissolveCircle(pos: Vector2, radius: int, amount: int = 1024):
	var instance: CPUParticles2D = effect_scene.instantiate()
	add_child(instance)
	instance.position = pos
	instance.emission_sphere_radius = radius
	instance.emission_shape = 1  # 1 is a sphere
	instance.amount = amount
	instance.emitting = true
