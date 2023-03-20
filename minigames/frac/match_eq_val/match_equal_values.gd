extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

const Bubble2 = preload("res://minigames/generics/bouncing_bubbles/new_bubble.gd")
var representation_a : Array
var representation_b : Array
var bubble_pairs := 5

func _add_specifics() -> void:
		
	_mk_bubbles()


func _mk_bubbles() -> void:
	for i in range(bubble_pairs):
		_mk_bubble_pair()

func _get_relative_prime(number : int, numbers : Array) -> int:
	for i in numbers:
		if i % number != 0:
			return i
	return -1

func _mk_bubble_pair() -> void:
	var position_area : Vector2 = 0.7*get_viewport_rect().size
	randomize()
	var denominators := [2, 3, 4, 5, 6, 7, 8, 9]
	denominators.shuffle()
	var denominator : int = denominators.pop_front()
	var numerator : int = _get_relative_prime(denominator, denominators)
	var factor : int = randi() % 9 + 2
	
	var bubble_a := Bubble2.new()
	bubble_a.sprite.sprite_frames.add_frame(
			"default",
			load("res://minigames/generics/assets/circle_white.svg")
	)
	bubble_a.sprite.sprite_frames.add_frame(
			"default",
			load("uid://byv8vhln6eltv")
	)	
	bubble_a.start(Vector2(position_area.x*randf(), position_area.y*randf()), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.int_value = [numerator, denominator]
	bubble_a.representation = REPRESENTATION_A
	
	add_child(bubble_a)
	bubble_a.add_child(FracLabel.new(str(numerator), str(denominator), 36))
	
	var bubble_b := Bubble2.new()
	bubble_b.sprite.sprite_frames.add_frame(
			"default",
			load("res://minigames/generics/assets/circle_yellow.svg")
	)
	bubble_b.sprite.sprite_frames.add_frame(
			"default",
			load("uid://byv8vhln6eltv")
	)

	bubble_b.start(Vector2(800, 300), 3.14*randf())
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_b.int_value = [numerator, denominator]	
	bubble_b.representation = REPRESENTATION_B

	
	add_child(bubble_b)	
	bubble_b.add_child(FracLabel.new(str(factor*numerator), str(factor*denominator), 36))

func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	var are_equal : bool = get_node(bubble1).int_value[0] == get_node(bubble2).int_value[0]
	if are_equal:
		are_equal = get_node(bubble1).int_value[1] == get_node(bubble2).int_value[1]
	return are_equal
