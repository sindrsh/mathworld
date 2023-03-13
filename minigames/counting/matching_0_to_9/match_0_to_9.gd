extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

var bubble_pairs := 5

func _add_specifics() -> void:
	
	representation_a = [
		preload("res://minigames/generics/bouncing_bubbles/assets/one.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/two.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/three.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/four.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/five.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/six.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/seven.svg"),
		preload("res://minigames/generics/bouncing_bubbles/assets/eight.svg"),	
		preload("res://minigames/generics/bouncing_bubbles/assets/nine.svg"),
	]
	representation_b = [
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
	_mk_bubbles()

func _mk_bubbles() -> void:
	for i in range(bubble_pairs):
		_mk_bubble_pair()

func _mk_bubble_pair() -> void:
	# note: bubble_number is 1 less than the value the bubble represents
	var bubble_number : int = randi() % 9
	var position_area : Vector2 = 0.7*get_viewport_rect().size
	var bubble_a : Bubble = bubble.duplicate()
	bubble_a.get_node("NumberSymbol").texture = representation_a[bubble_number] 
	bubble_a.start(Vector2(position_area.x*randf(), position_area.y*randf()), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.int_value = [bubble_number, 1]
	bubble_a.representation = REPRESENTATION_A
	add_child(bubble_a)
	
	var bubble_b : Bubble = bubble.duplicate()
	bubble_b.get_node("NumberSymbol").texture = representation_b[bubble_number] 
	bubble_b.start(Vector2(800, 300), 3.14*randf())
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_b.int_value = [bubble_number, 1]	
	bubble_b.representation = REPRESENTATION_B
	add_child(bubble_b)	

func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	return get_node(bubble1).int_value[0] == get_node(bubble2).int_value[0]
