extends CharacterBody2D

var speed : float = 1000.0
var target : Vector2
var moving = false
var is_hitting = false
var miss_sound : AudioStream = preload("res://minigames/generics/assets/whip.mp3")
var hit_sound : AudioStream = preload("res://minigames/generics/assets/correct.mp3")

signal move_completed

func _physics_process(_delta):
	if moving:
		velocity = position.direction_to(target) * speed
		if is_hitting:
			if position.distance_to(target) > 80:
				move_and_slide()
			else:
				moving = false
				$BeamSound.stream = hit_sound
				$BeamSound.play()
				emit_signal("move_completed")
		else:
			if position.distance_to(target) > 120:
				move_and_slide()
			else:
				moving = false
				$BeamSound.stream = miss_sound
				$BeamSound.play()
				emit_signal("move_completed")
