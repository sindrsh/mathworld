extends CharacterBody2D

var speed : float = 1000.0
var target : Vector2
var moving = false

signal move_completed

func _physics_process(_delta):
	if moving:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) > 10:
			move_and_slide()
		else:
			position = target
			moving = false
			emit_signal("move_completed")
