extends Node2D


var ball_scene: PackedScene = preload("res://components/ball/ball.tscn")
@export var ball_container: Node2D


func dispense():
	var ball = ball_scene.instantiate()
	ball_container.add_child(ball)
	ball.position = position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
