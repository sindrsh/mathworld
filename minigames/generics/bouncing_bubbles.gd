extends Node2D

var bubble : CharacterBody2D = preload("res://minigames/generics/bubble.tscn").instantiate()

func _ready():
	var window : Vector2 = get_viewport_rect().size
	$LeftWall/Border.shape.a = Vector2(0, 0)
	$LeftWall/Border.shape.b = Vector2(0, window.y)
	$RightWall/Border.shape.a = Vector2(window.x, 0)
	$RightWall/Border.shape.b = Vector2(window.x, window.y)
	$BottomWall/Border.shape.a = Vector2(0, window.y)
	$BottomWall/Border.shape.b = window	
	$TopWall/Border.shape.a = Vector2(0, 0)
	$TopWall/Border.shape.b = Vector2(window.x, 0)			
	
	bubble.get_node("BubbleSprite").sprite_frames.add_frame(
			"default",
			load("uid://d1lpn21diaxkw")
	)
	bubble.get_node("BubbleSprite").sprite_frames.add_frame(
			"default",
			load("uid://byv8vhln6eltv")
	)
	bubble.get_node("BubbleButton").texture_normal = load("uid://bwvslu284rc4s")
	
	_mk_bubble_pair()

func _on_bubble_pressed(_name : String):
	get_node(_name).get_node("BubbleSprite").frame = 1

func _mk_bubble_pair() -> void:
	# note: bubble_number is 1 less than the value the bubble represents
	var bubble_number : int = randi() % 9
	var bubble_a : CharacterBody2D = bubble.duplicate()
	bubble_a.get_node("NumberSymbol").texture = bubble_a.representation2[bubble_number] 
	bubble_a.start(Vector2(300, 300), 20)
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	add_child(bubble_a)
	
	var bubble_b : CharacterBody2D = bubble.duplicate()
	bubble_b.get_node("NumberSymbol").texture = bubble_a.representation2[bubble_number] 
	bubble_b.start(Vector2(800, 300), 20)
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	add_child(bubble_b)	
		
