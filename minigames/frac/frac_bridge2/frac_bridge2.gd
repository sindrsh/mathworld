extends "res://minigames/generics/cross_the_bridge/bridge_crossing.gd"

var denominator = 5
var numerator = 4
var denominator_answer : int
var numerator1_answer : int
var numerator2_answer : int
var factor := 1
var max_denom :int = 8
var max_num : int

var plus_num_btn := TextureButton.new()
var plus_denom_btn := TextureButton.new()
var min_num_btn := TextureButton.new()
var min_denom_btn := TextureButton.new()
var fraction_bar := Line2D.new()


func _add_specifics():
	assert(plus_num_btn.connect("pressed", _plus_num_pressed) == 0)
	assert(min_num_btn.connect("pressed", _min_num_pressed) == 0)	
	assert(plus_denom_btn.connect("pressed", _plus_denom_pressed) == 0)
	assert(min_denom_btn.connect("pressed", _min_denom_pressed) == 0)	
		
	plus_num_btn.texture_normal = plus_texture
	min_num_btn.texture_normal = min_texture
	plus_denom_btn.texture_normal = plus_texture
	min_denom_btn.texture_normal = min_texture
	
	plus_num_btn.position = Vector2(300, 50)
	min_num_btn.position = Vector2(100, 50)
	plus_denom_btn.position = plus_num_btn.position + Vector2(0, 200)
	min_denom_btn.position = min_num_btn.position + Vector2(0, 200)
	
	add_child(plus_denom_btn)
	add_child(plus_num_btn)
	add_child(min_denom_btn)
	add_child(min_num_btn)

	number.add_child(fraction_bar)		

func _physics_process(_delta):
	if number.moving:
		plus_denom_btn.hide()	
		min_denom_btn.hide()	
		plus_num_btn.hide()	
		min_num_btn.hide()	
	else: 
		plus_denom_btn.show()	
		min_denom_btn.show()	
		plus_num_btn.show()	
		min_num_btn.show()	
	

func _plus_num_pressed():
	max_num = int(max_int/(1.0/denominator)) 
	
	if numerator < max_num:
		number_line.queue_free()
		numerator += 1
		_mk_num_line()


func _min_num_pressed():
	max_num = int(max_int/(1.0/denominator)) 
	
	if numerator > 0:
		number_line.queue_free()
		numerator -= 1
		_mk_num_line()


func _plus_denom_pressed():
	numerator = 0
	if denominator < max_denom:
		number_line.queue_free()
		denominator+= 1
		_mk_num_line()

func _min_denom_pressed():
	numerator = 0
	if denominator > 2:
		number_line.queue_free()
		denominator -= 1
		_mk_num_line()

func _correct_answer():
	return numerator == abs(numerator1_answer + factor*numerator2_answer) and denominator == denominator_answer	

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
	fraction_bar.default_color = Color(1,0,0)
	fraction_bar.points = PackedVector2Array([
		Vector2(0, 0),
		Vector2(numerator*dx*x_scale, 0)
	])
	
	number_line.position = number_line_pos
	add_child(number_line)	

func _number_arrival_specifics() -> void:
	number_line.queue_free()

func _prepare_task() -> void:
	
	plus_num_btn.show()
	plus_denom_btn.show()
	min_num_btn.show()
	min_denom_btn.show()
	
	numerator = 0
	denominator = 1
	
	randomize()
	denominator_answer = randi() % (max_denom-1) + 2
	var dx : float = 1.0/denominator_answer
	numerator1_answer = randi() % int(max_int/dx) + 1
	numerator2_answer = 0
	if numerator1_answer != int(max_int/dx):
		while true:
			numerator2_answer = randi() % (int(max_int/dx) - numerator1_answer)
			if numerator2_answer != numerator1_answer:
				break
	var operator := "+"
	factor = 1
	if randi() % 2 == 1:
		operator = " \u2212 " 
		factor = -1
		var a : int = numerator1_answer
		var b : int = numerator2_answer
		if a < b:
			numerator2_answer = a
			numerator1_answer = b
	
	number.position = number_line_pos + Vector2(0,-40)
	
	var road1 : Line2D = Line2D.new()
	var road2 : Line2D = Line2D.new()
	
	road1.points = PackedVector2Array([
		road_start,
		Vector2(300, road_start.y)
	])
	road1.default_color = Color(0,0,0)
	add_child(road1)
	varying_objects.append(road1)
	
	var numerator_sum : int = abs(numerator1_answer + factor*numerator2_answer)
	road2.points = PackedVector2Array([
		road1.points[1] + Vector2(x_scale*numerator_sum/denominator_answer, 0),
		road1.points[1] + Vector2(x_scale*numerator_sum/denominator_answer + 300, 0)
	])
	road2.default_color = Color(0,0,0)
	add_child(road2)
	varying_objects.append((road2))
	
	var frac1_text := FracLabel.new(str(numerator1_answer), str(denominator_answer), 30)
	var frac2_text := FracLabel.new(str(numerator2_answer), str(denominator_answer), 30)
	frac1_text.position = Vector2(-50, 0)
	frac2_text.position = Vector2(50, 0)
	var operator_text = Text.new(50, operator)
	operator_text.set_text_position(Vector2(0,-35))
	var frac_text := Node2D.new()
	frac_text.add_child(frac1_text)
	frac_text.add_child(frac2_text)
	frac_text.add_child(operator_text)
	frac_text.position = road1.points[1] + Vector2(x_scale*numerator1_answer/(2*denominator_answer), 0) + Vector2(0, 60)
	add_child(frac_text)
	varying_objects.append(frac_text)
	
	pickable_object.position = road2.points[1] + Vector2(-20,-45)
	pickable_object.show()
	creature.show()
	creature.target = Vector2(pickable_object.position.x, creature.position.y)
	number.target = road1.points[1]
	
