extends Node2D

const Bubble = preload("res://minigames/generics/bouncing_bubbles/bubble.gd")
var bubble : Bubble = preload("res://minigames/generics/bouncing_bubbles/bubble.tscn").instantiate()
var chosen_bubbles := PackedStringArray(['', ''])
var representation_b : Array = [
	preload("res://minigames/generics/bouncing_bubbles/assets/1b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/2b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/3b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/4b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/5b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/6b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/7b.svg"),
	preload("res://minigames/generics/bouncing_bubbles/assets/8b.svg"),	
	preload("res://minigames/generics/bouncing_bubbles/assets/9b.svg"),
]

var left_wall := StaticBody2D.new()
var right_wall := StaticBody2D.new()
var top_wall := StaticBody2D.new()
var bottom_wall := StaticBody2D.new()

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
	
	_mk_bubble_pair()
	
func _on_bubble_pressed(_name : String) -> void:
	if _name in chosen_bubbles:
		return
	get_node(_name).get_node("BubbleSprite").frame = 1
	if chosen_bubbles[1]:
		get_node(chosen_bubbles[1]).get_node("BubbleSprite").frame = 0
	chosen_bubbles[1] = chosen_bubbles[0]
	chosen_bubbles[0] = _name
	
	if chosen_bubbles[0] != '' and chosen_bubbles[1] != '':
		if get_node(chosen_bubbles[0]).representation != get_node(chosen_bubbles[0]).representation:
			if _are_bubbles_equal():
				get_node(chosen_bubbles[0]).queue_free()
				get_node(chosen_bubbles[1]).queue_free()
			
func _are_bubbles_equal() -> bool:
	return get_node(chosen_bubbles[0]).number == get_node(chosen_bubbles[0]).number
			

func _mk_bubble_pair() -> void:
	# note: bubble_number is 1 less than the value the bubble represents
	var bubble_number : int = randi() % 9
	var bubble_a : Bubble = bubble.duplicate()
	bubble_a.get_node("NumberSymbol").texture = representation_b[bubble_number] 
	bubble_a.start(Vector2(300, 300), 20)
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	add_child(bubble_a)
	
	var bubble_b : Bubble = bubble.duplicate()
	bubble_b.get_node("NumberSymbol").texture = representation_b[bubble_number] 
	bubble_b.start(Vector2(800, 300), -90)
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	add_child(bubble_b)	
	
