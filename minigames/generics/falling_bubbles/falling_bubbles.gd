extends Control

const Bubble = preload("res://minigames/generics/falling_bubbles/bubble.gd")
const Bullet = preload("res://minigames/generics/falling_bubbles/bullet.gd")
var chosen_bubble : String
var bullet_container = Node2D.new()
var ints = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var score := 0
var window : Vector2
var bubble : Bubble

var audio_player := AudioStreamPlayer2D.new()
var correct_sound : AudioStream = preload("res://minigames/generics/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/generics/assets/whip.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	window = get_viewport_rect().size
	add_child(bullet_container)
	_make_task()
	
	
func _make_task() -> void:
	chosen_bubble = ''
	if bubble:
		bubble.queue_free()
	for _bullet in bullet_container.get_children():
		bullet_container.remove_child(_bullet)
		_bullet.queue_free() 
		
	randomize()
	var a : int = ints[randi() % 9]
	var b : int = ints[randi() % 9]
	_add_bubble([a, b])
	
	var x_values = [-1, 1, -3, 3]
	x_values.shuffle()
	
	_add_bullet(a*b, x_values.pop_back())
	
	var a_ints := ints.duplicate(true)
	var b_ints := ints.duplicate(true)
	a_ints.remove_at(a-1)
	b_ints.remove_at(b-1)
	a_ints.shuffle()
	b_ints.shuffle()
	for i in range(3):
		var random_index = randi() % a_ints.size()
		a = a_ints[random_index]
		a_ints.remove_at(random_index)
		random_index = randi() % b_ints.size()
		b = b_ints[random_index]
		b_ints.remove_at(random_index)
		_add_bullet(a*b, x_values[i])
		
		
func _add_bubble(values : Array) -> void:
	bubble = Bubble.new()
	assert(bubble.connect("bubble_pressed", _on_bubble_pressed) == 0)
	var bubble_string := Text.new(30, str(values[0]) +  " \u00B7 " + str(values[1]))
	bubble_string.center_text()
	bubble.int_value = values
	add_child(bubble)
	bubble.add_child(bubble_string)
	bubble.position = Vector2(window.x/2, 0)
	

func _add_bullet(value : int, x_adjust : int) -> void:
	var bullet := Bullet.new()
	assert(bullet.connect("bullet_pressed", _on_bullet_pressed) == 0)
	assert(bullet.connect("target_reached", _on_target_reached) == 0)	
	bullet.int_value = [value]
	bullet.position = Vector2(x_adjust*200 + window.x/2, window.y - 150)	
	bullet_container.add_child(bullet)

	var bullet_string = Text.new(40, str(value))
	bullet_string.center_text()
	bullet.add_child(bullet_string)


func _on_bullet_pressed(_name : String) -> void:
	if _name == chosen_bubble:
		bullet_container.get_node(_name).sprite.frame = 0
		chosen_bubble = ''
	else:
		if chosen_bubble == '':
			bullet_container.get_node(_name).sprite.frame = 1
			chosen_bubble = _name
		else:
			bullet_container.get_node(chosen_bubble).sprite.frame = 0
			bullet_container.get_node(_name).sprite.frame = 1
			chosen_bubble = _name

func _on_target_reached(_name : String) -> void:
	var finished_bullet = bullet_container.get_node(_name)
	var bullet_target : CharacterBody2D = finished_bullet.target_node
	if finished_bullet.equals_bubble:
		score += 1
		if score == 9:
			await get_tree().create_timer(0.1).timeout
			_end_game()
		else:
			_make_task()
	else:
		get_tree().reload_current_scene()

	

func _on_bubble_pressed(_name : String) -> void:
	if chosen_bubble:
		var mult : Array = get_node(_name).int_value
		if bullet_container.get_node(chosen_bubble).int_value[0] == mult[0]*mult[1]:
			bullet_container.get_node(chosen_bubble).equals_bubble = true
		
		bullet_container.get_node(chosen_bubble).target_node = get_node(_name)
		

func _correct_bullet() -> bool:
	return false


func _end_game_message():
	return "Mini game completed!"


func _end_game() -> void:
	var message = load("res://minigames/generics/SuccessMessage.tscn").instantiate()
	message.get_node("Label").text = _end_game_message()
	add_child(message)	
