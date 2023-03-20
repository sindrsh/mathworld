extends Node2D

const Bubble = preload("res://minigames/generics/bouncing_bubbles/bubble.gd")
var bubble : Bubble = preload("res://minigames/generics/bouncing_bubbles/bubble.tscn").instantiate()
var chosen_bubble : String
enum {REPRESENTATION_A, REPRESENTATION_B}

var left_wall := StaticBody2D.new()
var right_wall := StaticBody2D.new()
var top_wall := StaticBody2D.new()
var bottom_wall := StaticBody2D.new()
var audio_player := AudioStreamPlayer2D.new()
var correct_sound : AudioStream = preload("res://minigames/generics/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/generics/assets/whip.mp3")

func _ready():
	var window : Vector2 = get_viewport_rect().size
	
	var border_shape = CollisionShape2D.new()
	border_shape.shape = SegmentShape2D.new()
	
	var left_border = CollisionShape2D.new()
	left_border.shape = SegmentShape2D.new()
	left_border.shape.a = Vector2(0, 0)
	left_border.shape.b = Vector2(0, window.y)
	left_wall.add_child(left_border)
	var right_border = CollisionShape2D.new()
	right_border.shape = SegmentShape2D.new()
	right_border.shape.a = Vector2(window.x, 0)
	right_border.shape.b = Vector2(window.x, window.y)
	right_wall.add_child(right_border)
	var bottom_border = CollisionShape2D.new()
	bottom_border.shape = SegmentShape2D.new()
	bottom_border.shape.a = Vector2(0, window.y)
	bottom_border.shape.b = window	
	bottom_wall.add_child(bottom_border)
	var top_border = CollisionShape2D.new()
	top_border.shape = SegmentShape2D.new()
	top_border.shape.a = Vector2(0, 0)
	top_border.shape.b = Vector2(window.x, 0)			
	top_wall.add_child(top_border)
	
	bubble.get_node("BubbleSprite").sprite_frames.add_frame(
			"default",
			load("uid://d1lpn21diaxkw")
	)
	bubble.get_node("BubbleSprite").sprite_frames.add_frame(
			"default",
			load("uid://byv8vhln6eltv")
	)
	bubble.get_node("BubbleButton").texture_normal = load("uid://bwvslu284rc4s")
	
	add_child(left_wall)
	add_child(right_wall)
	add_child(bottom_wall)
	add_child(top_wall)
	add_child(audio_player)
	
	_add_specifics()

func _add_specifics():
	pass
	
func _on_bubble_pressed(_name : String) -> void:
	if _name == chosen_bubble:
		get_node(_name).sprite.frame = 0
		chosen_bubble = ''
	else:
		if chosen_bubble == '':
			get_node(_name).sprite.frame = 1
			chosen_bubble = _name
		elif get_node(chosen_bubble).representation != get_node(_name).representation:
			if _bubbles_are_equal(_name, chosen_bubble):
				audio_player.stream = correct_sound
			else:
				audio_player.stream = incorrect_sound
			
			audio_player.play()
			get_node(chosen_bubble).queue_free()
			get_node(_name).queue_free()
			chosen_bubble = ''
				
func _bubbles_are_equal(_bubble1 : String, _bubble2 : String) -> bool:
	return false
			


	
