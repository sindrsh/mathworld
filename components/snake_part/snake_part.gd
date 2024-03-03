extends Area2D
class_name SnakePart

var front: SnakePart  # if this is null, it means that this is the head of the snake. Really wish Godot had type unions.
var back: SnakePart

func move(direction: Vector2):
	# move in the direction
	# tell the snake behind me to move in a direction towards where I am
	pass

func grow():
	if back != null:
		back.grow()
		return
	# add a new part behind me


func _on_area_entered(area):
	die()

func die():
	# start death animation
	
	if back != null:
		back.die()
