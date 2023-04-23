extends MiniGame

const Bubble = preload("res://minigames/generics/falling_bubbles/bubble.gd")
const Bullet = preload("res://minigames/generics/falling_bubbles/bullet.gd")
var chosen_bubble : String
var bullet_container = Node2D.new()

var score := 0
var window : Vector2
var bubble : Bubble
var max_score

var audio_player := AudioStreamPlayer2D.new()
var correct_sound : AudioStream = preload("res://minigames/generics/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/generics/assets/whip.mp3")


# Called when the node enters the scene tree for the first time.
func _add_generics():
	window = get_viewport_rect().size
	add_child(bullet_container)
	
	
func _make_task() -> void:
	pass
		

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
	
func _on_bubble_pressed(_name : String) -> void:
	if chosen_bubble:
		if _correct_bullet(_name):
			bullet_container.get_node(chosen_bubble).equals_bubble = true
		bullet_container.get_node(chosen_bubble).target_node = get_node(_name)
		

func _correct_bullet(_name : String) -> bool:
	return false
		

func _on_target_reached(_name : String) -> void:
	var finished_bullet = bullet_container.get_node(_name)
	if finished_bullet.equals_bubble:
		score += 1
		if _accomplished():
			await get_tree().create_timer(0.1).timeout
			_end_game()
		else:
			_make_task()
	else:
		get_tree().reload_current_scene()

		
func _end_game_message():
	return "Mini game completed!"


func _end_game() -> void:
	var message = load("res://minigames/generics/SuccessMessage.tscn").instantiate()
	message.get_node("Label").text = _end_game_message()
	add_child(message)	


func _accomplished() -> bool:
	return false
