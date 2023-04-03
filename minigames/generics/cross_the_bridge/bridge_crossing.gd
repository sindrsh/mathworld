extends MiniGame

var x_scale : float = 500.0
var dy : float = 40.0


var max_int : int = 2
var max_length : float = max_int*x_scale
var number_line_pos : Vector2 = Vector2(600, 100)
var varying_objects : Array 
var number_line : NumberLine

var score_label : Text
var max_score : int
var score : int
var correct_sound : AudioStream = preload("res://minigames/generics/cross_the_bridge/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/generics/cross_the_bridge/assets/whip.mp3")
var finished_sound : AudioStream = preload("res://minigames/generics/cross_the_bridge/assets/success.mp3")
var road_start : Vector2 = Vector2(100, 700)
var creature_start_pos : Vector2 = road_start + Vector2(20,-50)

var number : CharacterBody2D = preload("res://minigames/generics/cross_the_bridge/number.tscn").instantiate()
var creature : CharacterBody2D = preload("res://minigames/generics/cross_the_bridge/creature.tscn").instantiate()
var send_number_button := Button.new()
var new_task_timer := Timer.new()
var score_count := Node2D.new()
var sound_effect := AudioStreamPlayer2D.new()
var pickable_object := Sprite2D.new()
var number_line_varies := false

var creature_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/Godot_icon.svg.png")
var pickable_object_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/star.png")
var plus_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/plus.png")
var min_texture : Texture2D = preload("res://minigames/generics/cross_the_bridge/assets/min.png")


func _add_generics() -> void:
	assert(creature.connect("move_completed", _on_creature_arrival) == 0)	
	assert(send_number_button.connect("pressed", _send_number) == 0)
	assert(number.connect("move_completed", _on_number_arrival) == 0)
	assert(new_task_timer.connect("timeout", _on_timeout) == 0)
	
	new_task_timer.one_shot = true
	
	new_task_timer.wait_time = 0.4
	var score_sprite := Sprite2D.new()	
	score_sprite.texture = pickable_object_texture
	score_sprite.scale = 0.05*Vector2(1,1)
	score_count.add_child(score_sprite)
	score_count.position = Vector2(1820, 164)
	score_label = Text.new(30, "0")
	score_label.set_text_position(Vector2(0,-20))
	score_count.add_child(score_label)

	sound_effect.stream = incorrect_sound
	
	send_number_button.position = Vector2(100, 430)
	send_number_button.text = "Go!"
	send_number_button.custom_minimum_size = Vector2(300, 100)
	var custom_style = StyleBoxFlat.new()
	custom_style.set_bg_color(Color(0.33, 0.67, 0.56, 1))
	send_number_button.set("theme_override_styles/normal", custom_style)
	
	
	var creature_sprite := Sprite2D.new()
	creature_sprite.scale = 0.05*Vector2(1,1)
	creature_sprite.texture = creature_texture
	creature.position = creature_start_pos
	creature.add_child(creature_sprite)
	
	pickable_object.texture = pickable_object_texture
	pickable_object.scale = 0.05*Vector2(1,1)
	
	add_child(score_count)
	add_child(send_number_button)
	add_child(creature)
	add_child(number)
	add_child(sound_effect)
	add_child(new_task_timer)
	add_child(pickable_object)
	
	max_score = 5
	
	_mk_task()

func _add_specifics() -> void:
	pass	

func _prepare_task() -> void:
	pass

func _mk_task() -> void:
	for i in range(varying_objects.size()):
		varying_objects[i].queue_free()
	varying_objects = []
	
	creature.show()
	pickable_object.show()
	
	_prepare_task()
	_mk_num_line()
	
func _mk_num_line() -> void:
	pass


func _on_creature_arrival() -> void:
	new_task_timer.start()
	creature.hide()
	pickable_object.hide()
	creature.moving = false
	creature.position = creature_start_pos
	

func _correct_answer() -> bool:
	return false

func _number_arrival_specifics() -> void:
	pass

func _on_number_arrival() -> void:	
	_number_arrival_specifics()
	if _correct_answer():
		score += 1
		sound_effect.stream = correct_sound
		creature.moving = true
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
	

