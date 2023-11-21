extends MiniGame

var tick_scene = preload("res://minigames/counting/falling_numbers_0_to_9/tick.tscn")
var number_scene = preload("res://minigames/counting/falling_numbers_0_to_9/number.tscn")
var ticks = 10
var dx = 100
var line_a = Vector2(250,800)
var line_b = Vector2(line_a.x + (ticks-1)*dx, line_a.y)

var selected_number
var score = 0
var rounds = 3
var high_score

var difficulty = 1


func _on_num_selection(node):
	if selected_number == null or not is_instance_valid(selected_number):
		selected_number = node
	else:
		if selected_number.find_tick != true:
			selected_number.get_node("Sprite2D").frame = 0
		else:
			selected_number.get_node("Sprite2D").frame = 2	
		selected_number = node
	node.get_node("Sprite2D").frame = 1

	
func _on_tick_selection(node):
	node.get_node("Sprite2D").frame = 1
	node.get_node("ColorTimer").start()
	if selected_number != null and is_instance_valid(selected_number):
		selected_number.tick = node
		selected_number.find_tick = true

func _add_number():
	var number = number_scene.instantiate()
	add_child(number)
	
	assert(number.connect("selected", Callable(self, "_on_num_selection")) == 0)	

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var integer = rng.randi_range(0, 9)
	number.value = integer
	number.mk_number(str(integer), null, Vector2(-12,-4))
	number.position = Vector2(line_a. x + rng.randi_range(0, line_b.x - line_a. x), 100)
	number.add_to_group("numbers")
	
	
func validate(area, tick = null):
	var number = area.get_parent()
	number.get_node("ExitTimer").start()
	if tick != null:
		if snapped(number.value, 0.1) == snapped(tick.value, 0.1):
			score += 1
			$ScoreBox/ScoreLabel.text = str(score)
			number.get_node("Sprite2D").frame = 3
		else: 
			rounds -= 1
			number.get_node("Sprite2D").frame = 4
	else:
		rounds -= 1
		number.get_node("Sprite2D").frame = 4
	if score > 9:
		$ScoreBox/ScoreLabel.position.x = 10
	$RoundsBox/RoundsLabel.text = str(rounds)
	if rounds == 0:
		if high_score != null:
			if score > high_score:
				high_score = score
		else: high_score = score
		$ScoreBoard/HighScore.text = str(high_score)
		$NumberTimer.stop()
		get_tree().call_group("numbers", "queue_free")
		$Music.stop()
		$GameOver.play()
		$EndBox.show()
		$RestartButton.show()
		
		
func _on_restart():
	score = 0
	rounds = 3
	$RoundsBox/RoundsLabel.text = str(rounds)
	$ScoreBox/ScoreLabel.text = str(score)
	$EndBox.visible = false
	$RestartButton.hide()
	$NumberTimer.wait_time = 4
	$NumberTimer.start()
	$Music.play()
	
	
func _add_specifics():
	
	world_part = "counting"
	id = "falling_numbers_0_to_9"
	minigame_type = NUMBER_LINE
	
	for i in range(ticks):
		var tick = tick_scene.instantiate()
		add_child(tick)
		tick.position = Vector2(line_a.x + dx*i, line_a.y)
		tick.value = i
		assert(tick.connect("selected", Callable(self, "_on_tick_selection")) == 0)
	

	$ScoreBox/ScoreLabel.text = str(score)
	$ScoreBorder.position = $ScoreBox.position
	$ScoreBorder.size = $ScoreBox.size
	
	$RoundsBox.size = $ScoreBox.size
	$RoundsBox.position = $ScoreBox.position + Vector2(0, 150)
	$RoundsBox/RoundsLabel.text = str(rounds)
	$RoundsBorder.position = $RoundsBox.position
	$RoundsBorder.size = $RoundsBox.size
	
	$ScoreBoard.position = $RoundsBox.position + Vector2(0, 150)
	
	_mk_number(self, "0", null, Vector2(line_a.x, line_a.y+40), 0.5, 20, 5, 10, 10)
	_mk_number(self, "1", null, Vector2(line_a.x+dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	
	assert($NumberTimer.connect("timeout", Callable(self, "_add_number")) == 0 )
	assert($RestartButton.connect("pressed", Callable(self, "_on_restart")) == 0)
	$NumberTimer.start()
	$EndBox.hide()
	$RestartButton.hide()
	$Music.play()


func _mk_number(scene, number, decs, pos, num_scale = 1, x_sep = 20, comma_sep = 20, comma_sep2 = 5, comma_y = 5):
	var num_scene = preload("res://minigames/counting/falling_numbers_0_to_9/int.tscn")
	var num_list = []
	var comma
	var cnt = 0
	for digit in number:
		var dig = num_scene.instantiate()
		dig.scale = num_scale*Vector2(1, 1)
		dig.position = pos + Vector2(cnt*x_sep, 0)
		dig.frame = int(digit)
		cnt += 1
		scene.add_child(dig)
		num_list.append(dig)
	if decs != null:
		comma = _mk_operator(scene, 5, pos + Vector2(cnt*x_sep - comma_sep, comma_y), num_scale)
		num_list.append(comma)
		for digit in decs:
			var dig = num_scene.instantiate()
			dig.scale = num_scale*Vector2(1, 1)
			dig.position = pos + Vector2(cnt*x_sep + comma_sep2, 0)
			dig.frame = int(digit)
			cnt += 1
			scene.add_child(dig)
			num_list.append(dig)
	return num_list


func _mk_operator(scene, int_frame, pos, num_scale = 1):
	var op_scene = preload("res://minigames/counting/falling_numbers_0_to_9/operator.tscn")
	var op = op_scene.instantiate()
	op.scale = num_scale*Vector2(1, 1)
	op.frame = int_frame
	op.position = pos
	scene.add_child(op)
	return op


func _draw():
	draw_line(line_a, line_b, Color(0,0,0), 7)


var time = 0
func _process(delta):
	time += delta
	if time > 20: 
		$NumberTimer.wait_time = 0.9*$NumberTimer.wait_time
		time = 0


func _on_difficulty_timer_timeout():
	print("difficulty increased")
	difficulty += 1
