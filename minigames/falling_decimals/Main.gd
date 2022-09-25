extends Node2D

var tick_scene = preload("res://minigames/falling_decimals/Tick.tscn")
var number_scene = preload("res://minigames/falling_decimals/Number.tscn")
var ticks = 21
var dx = 70
var line_a = Vector2(200,800)
var line_b = Vector2(line_a.x + (ticks-1)*dx, line_a.y)

var selected_number
var score = 0
var rounds = 3

func _on_num_selection(node):
	if selected_number == null or not is_instance_valid(selected_number):
		selected_number = node
	else:
		if selected_number.find_tick != true:
			selected_number.get_node("Sprite").frame = 0
		else:
			selected_number.get_node("Sprite").frame = 2	
		selected_number = node
	node.get_node("Sprite").frame = 1

	
func _on_tick_selection(node):
	node.get_node("Sprite").frame = 1
	node.get_node("ColorTimer").start()
	if selected_number != null and is_instance_valid(selected_number):
		selected_number.tick = node
		selected_number.find_tick = true

func _add_number():
	var number = number_scene.instance()
	add_child(number)
	
	assert(number.connect("selected", self, "_on_num_selection") == 0)	

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var integer = rng.randi_range(0, 1)
	var decimal = rng.randi_range(0, 9)
	number.value = integer + 0.1*decimal
	number.mk_number(String(integer), String(decimal), Vector2(-12,-4))
	number.position = Vector2(line_a. x + rng.randi_range(0, line_b.x - line_a. x), 200)
	number.add_to_group("numbers")
	
func validate(area, tick = null):
	var number = area.get_parent()
	number.get_node("ExitTimer").start()
	if tick != null:
		if stepify(number.value, 0.1) == stepify(tick.value, 0.1):
			score += 1
			$ScoreBox/ScoreLabel.text = String(score)
			number.get_node("Sprite").frame = 3
		else: 
			rounds -= 1
			number.get_node("Sprite").frame = 4
	else:
		rounds -= 1
		number.get_node("Sprite").frame = 4
	if score > 9:
		$ScoreBox/ScoreLabel.rect_position.x = 10
	$RoundsBox/RoundsLabel.text = String(rounds)
	if rounds == 0:
		$NumberTimer.stop()
		get_tree().call_group("numbers", "queue_free")
		$Music.stop()
		$GameOver.play()
		$EndBox.show()
		$RestartButton.show()
		
func _on_restart():
	score = 0
	rounds = 3
	$RoundsBox/RoundsLabel.text = String(rounds)
	$ScoreBox/ScoreLabel.text = String(score)
	$EndBox.visible = false
	$RestartButton.hide()
	$NumberTimer.wait_time = 4
	$NumberTimer.start()
	$Music.play()
	
func _ready():
	
	for i in range(ticks):
		var tick = tick_scene.instance()
		add_child(tick)
		tick.position = Vector2(line_a.x + dx*i, line_a.y)
		tick.value = i*0.1
		assert(tick.connect("selected", self, "_on_tick_selection") == 0)
	
	var font = GlobalVariables.get_font()
	font.size = 40
	$ScoreBox/ScoreLabel.set("custom_fonts/font", font)
	$ScoreBox/ScoreLabel.text = String(score)
	$ScoreBorder.rect_position = $ScoreBox.rect_position
	$ScoreBorder.rect_size = $ScoreBox.rect_size
	
	$RoundsBox.rect_size = $ScoreBox.rect_size
	$RoundsBox.rect_position = $ScoreBox.rect_position + Vector2(0, 150)
	$RoundsBox/RoundsLabel.set("custom_fonts/font", font)
	$RoundsBox/RoundsLabel.text = String(rounds)
	$RoundsBorder.rect_position = $RoundsBox.rect_position
	$RoundsBorder.rect_size = $RoundsBox.rect_size

	GlobalVariables.mk_number("0", null, Vector2(line_a.x, line_a.y+40), 0.5, 20, 5, 10, 10)
	GlobalVariables.mk_number("0", "5", Vector2(line_a.x-10+5*dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	GlobalVariables.mk_number("1", null, Vector2(line_a.x+10*dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	GlobalVariables.mk_number("1", "5", Vector2(line_a.x-10+15*dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	GlobalVariables.mk_number("2", null, Vector2(line_a.x+20*dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	
	assert($NumberTimer.connect("timeout", self, "_add_number") == 0 )
	assert($RestartButton.connect("pressed", self, "_on_restart") == 0)
	#$Music.play()
	$NumberTimer.start()
	$EndBox.hide()
	$RestartButton.hide()
	$Music.play()

func _draw():
	draw_line(line_a, line_b, Color(0,0,0), 7, true)

var time = 0
func _process(delta):
	time += delta
	if time > 10: 
		$NumberTimer.wait_time = 0.8*$NumberTimer.wait_time
		time = 0
