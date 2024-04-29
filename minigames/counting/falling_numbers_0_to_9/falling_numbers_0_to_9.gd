extends MiniGame

var tick_scene = preload("res://minigames/counting/falling_numbers_0_to_9/tick.tscn")
var number_scene = preload("res://minigames/counting/falling_numbers_0_to_9/number.tscn")
var ticks = 10
var dx : float
var line_a = Vector2(250,800)
var line_b : Vector2

signal died
var numbers = []  # list of stuff that needs to be killed when the game is over
var selected_number
var score = 0
var rounds = 3
var high_score

var difficulty = 1
var time = 0

var tick_0 := Sprite2D.new()
var tick_1 := Sprite2D.new()
var tick_0_texture : Texture2D = preload("res://minigames/counting/falling_numbers_0_to_9/assets/zero_black.svg")
var tick_1_texture : Texture2D = preload("res://minigames/counting/falling_numbers_0_to_9/assets/one_black.svg")

func _on_num_selection(node):
	if selected_number == null or not is_instance_valid(selected_number):
		selected_number = node
	else:
		selected_number.remove_outline()
		selected_number = node
	selected_number.apply_outline()
	
func _on_tick_selection(node):
	node.get_node("Sprite2D").frame = 1
	node.get_node("ColorTimer").start()
	if selected_number != null and is_instance_valid(selected_number):
		selected_number.tick = node
		if not selected_number.find_tick:
			selected_number.get_node("NumberSprite").position += Vector2(15, -20)
		selected_number.find_tick = true
		selected_number.get_node("Sprite2D").frame = 1


func _add_number():
	var number = number_scene.instantiate()
	add_child(number)
	
	assert(number.selected.connect(_on_num_selection) == 0)	

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var integer = rng.randi_range(0, 9)
	number.value = integer
	number.get_node("NumberSprite").frame = integer
	number.get_node("NumberSprite").position += Vector2(-15, 5)
	number.position = Vector2(line_a. x + rng.randi_range(0, line_b.x - line_a. x), 100)
	number.add_to_group("numbers")
	
	
func validate(area, tick = null):
	var number = area.get_parent()
	number.moving = false
	number.get_node("ExitTimer").start()
	if tick != null:
		if snapped(number.value, 0.1) == snapped(tick.value, 0.1):
			score += 1
		else: 
			$NumberLine.frame += 1
			rounds -= 1
	else:
		$NumberLine.frame += 1
		rounds -= 1
		
	if rounds == 0:
		die()

func _on_restart():
	score = 0
	rounds = 3
	$NumberTimer.wait_time = 4
	$NumberTimer.start()
	$Music.play()


func die():
	for num in numbers:
		num.queue_free()  # calling queue free on another object is typically an antipattern, but there is no "script" for numbers so it's fine
	
	emit_signal("died")
	$NumberTimer.stop()
	get_tree().call_group("numbers", "queue_free")
	$Music.stop()
	$GameOver.play()
	$NumberLine.self_modulate = Color(0, 0, 0, 0)  # we just make it invisible so that it's children are still visible
	$NumberLine/BreakParticles.emitting = true


func _add_specifics():
	
	world_part = "counting"
	id = "falling_numbers_0_to_9"
	minigame_type = NUMBER_LINE
	
	var tex: Texture2D = $NumberLine.sprite_frames.get_frame_texture("default", 0)
	line_b = Vector2(line_a.x + tex.get_width(), line_a.y)
	$NumberLine.position = line_a + Vector2(0, -tex.get_height()/2)
	dx = tex.get_width()/float(ticks-1)
	
	tick_0.texture = tick_0_texture
	tick_1.texture = tick_1_texture
	tick_0.position = Vector2(line_a.x, line_a.y + 40)
	tick_1.position = Vector2(line_a.x + dx, line_a.y + 40)
	
	add_child(tick_0)
	add_child(tick_1)
	
	for i in range(ticks):
		var tick = tick_scene.instantiate()
		add_child(tick)
		connect("died", tick.on_death)
		tick.position = Vector2(line_a.x + dx*i, line_a.y)
		tick.value = i
		assert(tick.selected.connect(_on_tick_selection) == 0)
	
	
	assert($NumberTimer.connect("timeout", Callable(self, "_add_number")) == 0 )
	$NumberTimer.start()
	$Music.play()
	
	

func _process(delta):
	time += delta
	if time > 20: 
		$NumberTimer.wait_time = 0.9*$NumberTimer.wait_time
		time = 0


func _on_difficulty_timer_timeout():
	if difficulty < 10:
		$NumberTimer.wait_time -= 0.2
		difficulty += 1
