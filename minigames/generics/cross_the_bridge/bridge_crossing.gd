extends Node2D

var x_scale : float = 500.0
var dy : float = 40.0


var max_int : int = 2
var max_length : float = max_int*x_scale
var number_line_pos : Vector2 = Vector2(600, 100)
var objects : Array 
var number_line : NumberLine

var score_label : Text
var max_score : int
var score : int
var correct_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/whip.mp3")
var finished_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/success.mp3")
var road_start : Vector2 = Vector2(100, 700)
var creature_start_pos : Vector2 = road_start + Vector2(20,-50)

var number : CharacterBody2D = preload("res://minigames/generics/cross_the_bridge/number.tscn").instantiate()
var creature : CharacterBody2D = preload("res://minigames/generics/cross_the_bridge/creature.tscn").instantiate()
var send_number_button := Button.new()
var new_task_timer := Timer.new()
var score_count := Sprite2D.new()
var sound_effect := AudioStreamPlayer2D.new()
var pickable_object := Sprite2D.new()
var number_line_varies := false

var creature_texture : Texture2D = load("res://minigames/generics/cross_the_bridge/assets/Godot_icon.svg.png")
var plus_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/plus.png")
var min_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/min.png")


func _ready() -> void:
	assert(creature.connect("move_completed", _on_creature_arrival) == 0)	
	assert(send_number_button.connect("pressed", _send_number) == 0)
	assert(number.connect("move_completed", _on_number_arrival) == 0)
	assert(new_task_timer.connect("timeout", _on_timeout) == 0)
	
	new_task_timer.one_shot = true
		
	score_count.position = Vector2(1800, 50)
	score_label = Text.new(30, "0")
	score_label.set_text_position(score_count.position + Vector2(0,-15))
	
	sound_effect.stream = incorrect_sound
	
	send_number_button.position = Vector2(1775, 150)
	var send_frac_label : Text = Text.new(20, "Go!")
	send_number_button.add_child(send_frac_label)
	send_frac_label.set_text_position(Vector2(20,10))
	send_number_button.size = Vector2(50,50)
	
	var creature_sprite := Sprite2D.new()
	creature_sprite.scale = 0.05*Vector2(1,1)
	creature_sprite.texture = creature_texture
	creature.position = creature_start_pos
	creature.add_child(creature_sprite)
	
	add_child(score_label)
	add_child(send_number_button)
	add_child(creature)
	add_child(number)
	add_child(sound_effect)
	add_child(new_task_timer)
	
	max_score = 5
	_add_specifics()
	_mk_task()

func _add_specifics() -> void:
	pass	

func _mk_task() -> void:
	pass
	
	
func _mk_num_line() -> void:
	pass


func _on_creature_arrival() -> void:
	creature.hide()
	creature.moving = false
	creature.position = creature_start_pos
	pickable_object.hide()

func _correct_answer() -> bool:
	return false

func _arrival_specifics() -> void:
	pass

func _on_number_arrival() -> void:	
	_arrival_specifics()
	if _correct_answer():
		score += 1
		sound_effect.stream = correct_sound
		creature.moving = true
		new_task_timer.start()	
	else:
		score = 0
		sound_effect.stream = incorrect_sound
		_mk_task()
	score_label.text = str(score)	
	if score == max_score:
		sound_effect.stream = finished_sound
	sound_effect.play()
	
	
func _on_timeout() -> void:
	_mk_task()
	

func _send_number() -> void:
	number.moving = true
	

