extends "res://minigames/generics/cross_the_bridge/bridge_crossing.gd"

var denominator = 1
var numerator = 0
var answer : int
var factor := 1
var max_denom : int = 8
var max_num : int

var plus_num_btn := TextureButton.new()
var plus_denom_btn := TextureButton.new()
var min_num_btn := TextureButton.new()
var min_denom_btn := TextureButton.new()
var number_bar := Line2D.new()

var num_symbol := Line2D.new()
var denom_symbol := Line2D.new()
var pickable_object_texture : Texture2D = preload("res://minigames/counting/number_bridge_0_to_9/assets/vegetable point.png")

func _add_specifics():
	world_part = "counting"
	id = "number_bridge_0_to_9"
	minigame_type = NUMBER_LINE
	assert(plus_num_btn.connect("pressed", _plus_num_pressed) == 0)
	assert(min_num_btn.connect("pressed", _min_num_pressed) == 0)	
	assert(plus_denom_btn.connect("pressed", _plus_denom_pressed) == 0)
	assert(min_denom_btn.connect("pressed", _min_denom_pressed) == 0)	
	
	creature_animation = preload("res://minigames/counting/number_bridge_0_to_9/creature_animation.tscn").instantiate()
	creature.add_child(creature_animation)
	creature_animation.play()
	pickable_object.texture = pickable_object_texture
	pickable_object.scale = Vector2(0.4, 0.4)
	
	
	plus_num_btn.scale = 0.2*Vector2(1,1)
	plus_num_btn.texture_normal = plus_texture
	plus_num_btn.texture_pressed = plus_pressed_texture
	min_num_btn.scale = 0.2*Vector2(1,1)
	min_num_btn.texture_normal = min_texture
	min_num_btn.texture_pressed = min_pressed_texture
	plus_denom_btn.texture_normal = plus_texture
	min_denom_btn.texture_normal = min_texture
	
	plus_num_btn.position = Vector2(300, 50)
	min_num_btn.position = Vector2(150, 50)
	plus_denom_btn.position = plus_num_btn.position + Vector2(0, 200)
	min_denom_btn.position = min_num_btn.position + Vector2(0, 200)
	
	send_number_button.position = (plus_num_btn.position + min_num_btn.position)/2.0 + Vector2(0, 150)
	
#	add_child(plus_denom_btn)
	add_child(plus_num_btn)
#	add_child(min_denom_btn)
	add_child(min_num_btn)
	
	num_symbol.position = min_num_btn.position + Vector2(135,50) 
	num_symbol.points = PackedVector2Array([Vector2.ZERO, Vector2(30, 0)])
	num_symbol.width = 6
	num_symbol.default_color= Color(1,0,0)
	
	denom_symbol.position = min_denom_btn.position + Vector2(150,35) 
	denom_symbol.points = PackedVector2Array([Vector2.ZERO, Vector2(0, 30)])
	denom_symbol.width = 6
	denom_symbol.default_color= Color(0,0,0)
	
	#add_child(num_symbol)
	
	number.add_child(number_bar)
	
	x_scale = 100
	max_int = 9
	max_score = 5
	
	#$BridgeLeft.scale = Vector2(4, 2)
	#$BridgeRight.scale = Vector2(4, 2)
	$BridgeLeft.position = Vector2(200, 700)
	
	_mk_task()
	
	
func _plus_num_pressed():
	if number.moving:
		return
	max_num = int(max_int/(1.0/denominator)) 
	
	if numerator < max_num:
		number_line.queue_free()
		numerator += 1
		_mk_num_line()


func _min_num_pressed():
	if number.moving:
		return
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
	return numerator == answer

func _mk_num_line() -> void:
	var dx : float = 1.0
	number_line = NumberLine.new()
	number_line.mk_x_axis(0.0, max_int, x_scale)
	
	number_line.mk_x_tick(Vector2(0, 0), "0")
	number_line.mk_x_tick(Vector2(x_scale, 0),"1")
	for i in range(int(max_int/dx)+1):
		if i == numerator:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0), "", 1, Color(1,0,0))
		else:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0))
	number_bar.default_color = Color8(55, 144, 113)
	number_bar.points = PackedVector2Array([
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
	
	randomize()
	answer = randi() % 9 + 1
	number.position = number_line_pos + Vector2(0,-40)
		
	var bridge_left_length := 200.0
	var bridge_right_length := 1000.0 - bridge_left_length-x_scale*answer
	$BridgeLeft.region_rect = Rect2(0,0, bridge_left_length, 25)
	$BridgeRight.region_rect = Rect2(0,0, bridge_right_length, 25)
	$BridgeRight.position = Vector2($BridgeLeft.position.x + x_scale*answer + bridge_left_length, $BridgeLeft.position.y)
	
	var number_text := Text.new(50, str(answer))
	number_text.position = $BridgeLeft.position + Vector2(bridge_left_length + x_scale*answer/2, 0) + Vector2(0, 60)
	add_child(number_text)
	varying_objects.append(number_text)
	
	pickable_object.position = Vector2(1200, 600)
	pickable_object.show()
	creature.show()
	creature.target = Vector2(pickable_object.position.x, creature.position.y)
	number.target = $BridgeLeft.position + Vector2(bridge_left_length, 5)
	
