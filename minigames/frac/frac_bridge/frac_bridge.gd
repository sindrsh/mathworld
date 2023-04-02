extends "res://minigames/generics/cross_the_bridge/bridge_crossing.gd"

var denominator = 5
var numerator = 4
var denominator_answer : int
var numerator_answer : int
var max_denom :int = 8
var max_num : int

var plus_num_btn := TextureButton.new()
var plus_denom_btn := TextureButton.new()
var min_num_btn := TextureButton.new()
var min_denom_btn := TextureButton.new()
var fraction_bar := Line2D.new()

var num_symbol := Line2D.new()
var denom_symbol := Line2D.new()

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
	
	num_symbol.position = min_num_btn.position + Vector2(135,50) 
	num_symbol.points = PackedVector2Array([Vector2.ZERO, Vector2(30, 0)])
	num_symbol.width = 6
	num_symbol.default_color= Color(1,0,0)
	
	denom_symbol.position = min_denom_btn.position + Vector2(150,35) 
	denom_symbol.points = PackedVector2Array([Vector2.ZERO, Vector2(0, 30)])
	denom_symbol.width = 6
	denom_symbol.default_color= Color(0,0,0)
	
	add_child(num_symbol)
	add_child(denom_symbol)
	
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
	return numerator == numerator_answer and denominator == denominator_answer	

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
	numerator_answer = randi() % int(max_int/dx) + 1
	
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
	
	road2.points = PackedVector2Array([
		road1.points[1] + Vector2(x_scale*numerator_answer/denominator_answer, 0),
		road1.points[1] + Vector2(x_scale*numerator_answer/denominator_answer + 300, 0)
	])
	road2.default_color = Color(0,0,0)
	add_child(road2)
	varying_objects.append((road2))
	
	var frac_text : FracLabel = FracLabel.new(str(numerator_answer), str(denominator_answer), 30)
	frac_text.position = road1.points[1] + Vector2(x_scale*numerator_answer/(2*denominator_answer), 0) + Vector2(0, 60)
	add_child(frac_text)
	varying_objects.append(frac_text)
	
	pickable_object.position = road2.points[1] + Vector2(-20,-45)
	pickable_object.show()
	creature.show()
	creature.target = Vector2(pickable_object.position.x, creature.position.y)
	number.target = road1.points[1]
	
