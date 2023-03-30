extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

var representation_a : Array
var representation_b : Array
var bubble_pairs := 5
var score : = 0

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


func _mk_bubbles() -> void:
	for i in range(bubble_pairs):
		_mk_bubble_pair()


func _mk_bubble_pair() -> void:
	# note: bubble_number is 1 less than the value the bubble represents
	var bubble_number : int = randi() % 9
	var position_area : Vector2 = 0.7*get_viewport_rect().size
	var bubble_a := Bubble.new()
	
	bubble_a.start(Vector2(position_area.x*randf(), position_area.y*randf()), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.int_value = [bubble_number, 1]
	bubble_a.representation = REPRESENTATION_A
	bubble_a.set_frames()
	bubble_container.add_child(bubble_a)
	var number_symbol_a := Sprite2D.new()
	number_symbol_a.texture = representation_a[bubble_number] 
	bubble_a.add_child(number_symbol_a)
	
	var bubble_b := Bubble.new()
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
	bubble_b.int_value = [bubble_number, 1]
	bubble_b.representation = REPRESENTATION_B
	bubble_container.add_child(bubble_b)
	var number_symbol_b := Sprite2D.new()
	number_symbol_b.texture = representation_b[bubble_number] 
	bubble_b.add_child(number_symbol_b)


func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	var are_equal : bool = bubble_container.get_node(bubble1).int_value[0] == bubble_container.get_node(bubble2).int_value[0]
	if are_equal: score += 1
	return are_equal


func _end_game_message():
	return "Match the numbers completed!"


func _end_game_condition() -> bool:
	var got_all_right : bool = (score == bubble_pairs)
	if got_all_right: 
		return true
	if bubble_container.get_child_count() == 0:
		get_tree().reload_current_scene()
	return false
