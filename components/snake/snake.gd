extends Node2D

# Wherever this object is will be the initial "root" of the snake
var parts: Array[SnakePart]
var part_scene = preload("res://components/snake_part/snake_part.tscn")

func spawn_snake(pos: Vector2 = Vector2(0, 0), starting_parts: int = 4) -> void:
	# iterate through part scene spawning snakes
	pass
