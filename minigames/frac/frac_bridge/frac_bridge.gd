extends Node2D

var x_scale : float = 500.0
var dy : float = 40.0

var max_int : int = 2
var max_length : float = max_int*x_scale
var mouse_offset : Vector2
var number_line_pos : Vector2 = Vector2(600, 100)
var objects : Array 
var number_line : NumberLine
var fraction_bar : Line2D 
var denominator : int = 1
var numerator : int = 0 
var max_num : int
var max_denom : int = 8
var denominator_answer : int
var numerator_answer : int
var score_label : Text
var score : int = 0
var correct_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/correct.mp3")
var incorrect_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/whip.mp3")
var finished_sound : AudioStream = preload("res://minigames/frac/frac_bridge/assets/success.mp3")
var road_start : Vector2 = Vector2(100, 700)
var creature_start_pos : Vector2 = road_start + Vector2(20,-50)

	
func _mk_num_line() -> void:
	var dx : float = 1.0/denominator
	number_line = NumberLine.new()
	number_line.mk_x_axis(0.0, max_int, x_scale)
	
	number_line.mk_x_tick(Vector2(0, 0), "0")
	number_line.mk_x_tick(Vector2(x_scale, 0),"1")
	for i in range(int(max_int/dx)+1):
		if i == numerator:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0), "", 1, Color(1,0,0))
		else:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0))
	fraction_bar = Line2D.new()
	fraction_bar.default_color = Color(1,0,0)
	fraction_bar.points = PackedVector2Array([
		Vector2(0, 0),
		Vector2(numerator*dx*x_scale, 0)
	])
	
	number_line.position = number_line_pos
	add_child(number_line)	
	$Fraction.add_child(fraction_bar)


func _mk_task():
	for i in range(objects.size()):
		objects[i].queue_free()
	objects = []
	$PlusNum.show()
	$PlusDenom.show()
	$MinNum.show()
	$MinDenom.show()
	
	numerator = 0
	denominator = 1
	
	randomize()
	denominator_answer = randi() % (max_denom-1) + 2
	var dx : float = 1.0/denominator_answer
	numerator_answer = randi() % int(max_int/dx) + 1
	
	$Fraction.position = number_line_pos + Vector2(0,-40)
	
	var road1 : Line2D = Line2D.new()
	var road2 : Line2D = Line2D.new()
	
	road1.points = PackedVector2Array([
		road_start,
		Vector2(300, road_start.y)
	])
	road1.default_color = Color(0,0,0)
	add_child(road1)
	objects.append(road1)
	
	road2.points = PackedVector2Array([
		road1.points[1] + Vector2(x_scale*numerator_answer/denominator_answer, 0),
		road1.points[1] + Vector2(x_scale*numerator_answer/denominator_answer + 300, 0)
	])
	road2.default_color = Color(0,0,0)
	add_child(road2)
	objects.append((road2))
	
	var frac_text : FracLabel = FracLabel.new(str(numerator_answer), str(denominator_answer), 30)
	frac_text.position = road1.points[1] + Vector2(x_scale*numerator_answer/(2*denominator_answer), 0) + Vector2(0, 60)
	add_child(frac_text)
	objects.append(frac_text)
	
	$Star.position = road2.points[1] + Vector2(-20,-45)
	$Star.show()
	$Creature.show()
	$Fraction.target = road1.points[1]
	$Creature.target = Vector2($Star.position.x, $Creature.position.y)
	_mk_num_line()


func _plus_num_pressed():
	max_num = int(max_int/(1.0/denominator)) 
	
	if numerator < max_num:
		fraction_bar.queue_free()
		number_line.queue_free()
		numerator += 1
		_mk_num_line()


func _min_num_pressed():
	max_num = int(max_int/(1.0/denominator)) 
	
	if numerator > 0:
		fraction_bar.queue_free()
		number_line.queue_free()
		numerator -= 1
		_mk_num_line()


func _plus_denom_pressed():
	numerator = 0
	if denominator < max_denom:
		fraction_bar.queue_free()
		number_line.queue_free()
		denominator+= 1
		_mk_num_line()

func _min_denom_pressed():
	numerator = 0
	if denominator > 2:
		fraction_bar.queue_free()
		number_line.queue_free()
		denominator -= 1
		_mk_num_line()


func _on_creature_arrival():
	$Creature.hide()
	$Creature.position = creature_start_pos
	$Star.hide()


func _on_fraction_arrival():
	number_line.queue_free()
	if numerator == numerator_answer and denominator == denominator_answer:
		score += 1
		$AudioStreamPlayer2D.stream = correct_sound
		$Creature.moving = true
		$NewTask.start()	
	else:
		score = 0
		$AudioStreamPlayer2D.stream = incorrect_sound
		fraction_bar.queue_free()	
		_mk_task()
	score_label.text = str(score)	
	if score == 10:
		$AudioStreamPlayer2D.stream = finished_sound
	$AudioStreamPlayer2D.play()
	
	
func _on_timeout():
	fraction_bar.queue_free()
	_mk_task()
	

func _send_fraction():
	$Fraction.moving = true
	$Fraction.show()
	$PlusNum.hide()
	$PlusDenom.hide()
	$MinNum.hide()
	$MinDenom.hide()
	
func _ready():
	assert($PlusNum.connect("pressed", _plus_num_pressed) == 0)
	assert($MinNum.connect("pressed", _min_num_pressed) == 0)	
	assert($PlusDenom.connect("pressed", _plus_denom_pressed) == 0)
	assert($MinDenom.connect("pressed", _min_denom_pressed) == 0)	
	assert($Creature.connect("move_completed", _on_creature_arrival) == 0)	
	assert($SendFrac.connect("pressed", _send_fraction) == 0)
	assert($Fraction.connect("move_completed", _on_fraction_arrival) == 0)
	assert($NewTask.connect("timeout", _on_timeout) == 0)
	$Score.position = Vector2(1800, 50)
	score_label = Text.new(30, "0")
	score_label.set_text_position($Score.position + Vector2(0,-15))
	add_child(score_label)
	$AudioStreamPlayer2D.stream = incorrect_sound
	
	$SendFrac.position = Vector2(1775, 150)
	var send_frac_label : Text = Text.new(20, "Go!")
	$SendFrac.add_child(send_frac_label)
	send_frac_label.set_text_position(Vector2(20,10))
	$SendFrac.size = Vector2(50,50)
	
	$Creature.position = creature_start_pos
	
	_mk_task()
