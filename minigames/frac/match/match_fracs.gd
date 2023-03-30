extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

var fraction_scene = preload("res://minigames/frac/match/fraction.gd")
var representation_a : Array
var representation_b : Array
var bubble_pairs := 5
var score : = 0

func _mk_bubbles() -> void:
	for i in range(bubble_pairs):
		_mk_bubble_pair()


func _mk_bubble_pair() -> void:
	var position_area : Vector2 = 0.7*get_viewport_rect().size
	randomize()
	var denominator : int = randi() % 7 + 2
	var numerator : int = randi() % denominator + 1
	
	var bubble_a := Bubble.new()
	bubble_a.start(Vector2(position_area.x*randf(), position_area.y*randf()), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.int_value = [numerator, denominator]
	bubble_a.representation = REPRESENTATION_A
	bubble_a.set_frames()
	bubble_container.add_child(bubble_a)
	bubble_a.add_child(FracLabel.new(str(numerator), str(denominator), 36))		
	
	var bubble_b := Bubble.new()
	bubble_b.set_frames()
	bubble_b.start(Vector2(800, 300), 3.14*randf())
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_b.int_value = [numerator, denominator]	
	bubble_b.representation = REPRESENTATION_B

	var fraction : Node2D = fraction_scene.new(numerator, denominator, 47)
	bubble_container.add_child(bubble_b)	
	bubble_b.add_child(fraction)


func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	var are_equal : bool = bubble_container.get_node(bubble1).int_value[0] == bubble_container.get_node(bubble2).int_value[0]
	if are_equal: score += 1
	return are_equal


func _end_game_message():
	return "Match the fraction completed!"


func _end_game_condition() -> bool:
	var got_all_right : bool = (score == bubble_pairs)
	if got_all_right: 
		return true
	if bubble_container.get_child_count() == 0:
		get_tree().reload_current_scene()
	return false
