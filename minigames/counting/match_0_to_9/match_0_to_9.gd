extends "res://minigames/generics/bouncing_bubbles/bouncing_bubbles.gd"

var score : = 0
var ints := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
var music : AudioStreamMP3 = preload("res://minigames/generics/assets/game-music.mp3")
var b_background : Texture2D = preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png")
var nummber_symbol_b_texture := preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png")
var bubble_scene = preload("res://minigames/generics/bouncing_bubbles/bubble.tscn")
var bubbles = []

var representation_a = [
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 0.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 1.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 3.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 4.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 5.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 6.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 7.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 8.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles 9.png"),
	]
	
var representation_a_chosen = [
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 0.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 1.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 3.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 4.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 5.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 6.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 7.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 8.png"),
		preload("res://minigames/counting/match_0_to_9/assets/Purple Bubble 9.png"),
	]	
	
var	representation_b = [
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
		preload("res://minigames/counting/match_0_to_9/assets/bubbles empty 2.png"),
	]

var representation_b_chosen = preload("res://minigames/counting/match_0_to_9/assets/bubbles empty.png")

func _add_specifics() -> void:
	world_part = "counting"
	id = "match_0_to_9"
	minigame_type = AMOUNT
	music_player.stream = music
	
	_add_status_bar()
	
	
func _mk_bubbles() -> void:
	for i in range(ints.size()):
		_mk_bubble_pair()


func _mk_bubble_pair() -> void:
	var bubble_number : int = ints.pop_front()
	
	var bubble_a = bubble_scene.instantiate()
	bubble_a.int_value = [bubble_number, 1]
	bubble_a.representation = REPRESENTATION_A
	bubble_a.start(start_positions.pop_back(), 3.14*randf())
	assert(bubble_a.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_a.not_chosen_texture = representation_a[bubble_number]
	bubble_a.chosen_texture = representation_a_chosen[bubble_number]
	bubble_a.button.texture_normal = representation_a[bubble_number]
	
	var sc := 0.1
	bubble_a.button.scale = sc*Vector2(1,1)
	bubble_a.collision_shape.shape.radius = 0.5*sc*representation_a[bubble_number].get_height()
	bubble_a.button.position = -0.5*sc*representation_a[bubble_number].get_size()
	bubble_container.add_child(bubble_a)
	
	var bubble_b := bubble_scene.instantiate()
	bubble_b.int_value = [bubble_number, 1]
	bubble_b.representation = REPRESENTATION_B
	bubble_b.start(start_positions.pop_back(), 3.14*randf())
		
	assert(bubble_b.connect("bubble_pressed", _on_bubble_pressed) == 0)
	bubble_b.button.texture_normal = representation_b[bubble_number]
	bubble_b.not_chosen_texture = representation_b[bubble_number]
	bubble_b.chosen_texture = representation_b_chosen
	bubble_b.button.scale = sc*Vector2(1,1)
	bubble_b.collision_shape.shape.radius = 0.5*sc*representation_b[bubble_number].get_height()
	bubble_b.button.position = -0.5*sc*representation_b[bubble_number].get_size()
	bubble_container.add_child(bubble_b)
	if bubble_number != 0:
		var amount := Sprite2D.new()
		amount.texture = load("res://minigames/generics/assets/"+str(bubble_number)+"b.svg")
		amount.scale = 1.25*Vector2(1,1)
		bubble_b.add_child(amount)
	
	bubbles.append(bubble_a)
	bubbles.append(bubble_b)


func _bubbles_are_equal(bubble1 : String, bubble2 : String) -> bool:
	var are_equal : bool = bubble_container.get_node(bubble1).int_value[0] == bubble_container.get_node(bubble2).int_value[0]
	if are_equal: score += 1
	return are_equal

			
			
