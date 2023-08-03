extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

var representation_a : Array
var representation_b : Array
var score : = 0
var ints := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

func _add_specifics() -> void:
	world_part = "counting"
	id = "match_0_to_9"
	minigame_type = AMOUNT
	
	_add_status_bar()
	
	representation_a = [
		preload("res://minigames/generics/bouncing_bubbles/assets/zero.svg"),
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
		null,
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


func _mk_bubbles() -> void:
	for i in range(ints.size()):
		_mk_bubble_pair()


func _mk_bubble_pair() -> void:
	var bubble_number : int = ints.pop_front()
	var position_area : Vector2 = 0.7*get_viewport_rect().size
	
	var bubble_a := Bubble.new()
	bubble_a.int_value = [bubble_number, 1]
	bubble_a.representation = REPRESENTATION_A
	bubble_a.start(Vector2(position_area.x*randf(), position_area.y*randf()), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.set_frames()
	bubble_container.add_child(bubble_a)
	
	var number_symbol_a := Sprite2D.new()
	number_symbol_a.texture = representation_a[bubble_number] 
	bubble_a.add_child(number_symbol_a)
	
	var bubble_b := Bubble.new()
	bubble_b.int_value = [bubble_number, 1]
	bubble_b.representation = REPRESENTATION_B
	bubble_b.start(Vector2(800, 300), 3.14*randf())
	bubble_b.sprite.sprite_frames.add_frame(
			"default",
			bubble_b.button.texture_normal
			#load("res://minigames/generics/assets/circle_yellow.svg")
	)
	bubble_b.sprite.sprite_frames.add_frame(
			"default",
			load("res://minigames/generics/assets/circle_purple.svg")
	)	
	
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_container.add_child(bubble_b)
	var number_symbol_b := Sprite2D.new()
	number_symbol_b.texture = representation_b[bubble_number] 
	bubble_b.add_child(number_symbol_b)


func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	var are_equal : bool = bubble_container.get_node(bubble1).int_value[0] == bubble_container.get_node(bubble2).int_value[0]
	if are_equal: score += 1
	return are_equal


