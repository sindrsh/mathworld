extends Node2D

var ones_scene = preload("res://minigames/decimal_amounts/One1.tscn")
var tenths_scene = preload("res://minigames/decimal_amounts/One10th.tscn")
var hundredths_scene = preload("res://minigames/decimal_amounts/One100th.tscn")
var blank_tenths_scene = preload("res://minigames/decimal_amounts/BlankTenths.tscn")
var blank_hundredths_scene = preload("res://minigames/decimal_amounts/BlankHundredths.tscn")
var counter_scene = preload("res://minigames/decimal_amounts/Counter.tscn")

var ones = []
var blank_tenths = []
var tenths = []
var hundredths = []
var blank_hundredths = []
var level_labels = []
var level_counters = [] 

var dig1 = 0
var dig01 = 0
var dig001 = 0

var one_cnt = 0
var tenth_cnt = 0
var hundredth_cnt = 0 

var one_size = 200
var tenth_size = one_size/10

var one_sep = 30
var y_sep = 30
var one_y = 400
var tenth_y = one_y+one_size + y_sep
var hundredth_y = one_y + 2*(one_size + y_sep) 

var adjust_x = 120
var xpositions = [
	4*(one_size+one_sep) + adjust_x,
	3*(one_size+one_sep) + adjust_x,
	2*(one_size+one_sep) + adjust_x,
	one_size+one_sep + adjust_x				
]

var level = 0
var score = 0
var score_max = 7

var normal_box
var read_only_box

func _mk_one(pos):
	var one = ones_scene.instance()
	one.position = pos
	add_child(one)
	ones.append(one)

func _mk_tenth(pos):
	var tenth = tenths_scene.instance()
	tenth.position = pos
	add_child(tenth)
	tenths.append(tenth)
	
func _mk_hundredth(pos):
	var hundredth = hundredths_scene.instance()
	hundredth.position = pos
	add_child(hundredth)
	hundredths.append(hundredth)	
	

func _draw():
	draw_line(Vector2(50, 250), Vector2(1800, 250), Color(0, 0, 0), 5, true)

func _check_input(text):
	var valid = true
	var digit_strings = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
	for dig in text:
		var valid_char = false
		for digstring in digit_strings:
			if dig == digstring:
				valid_char = true
		if valid_char:
			break
		else: valid = false
		return valid

func _on_text_entered(new_text):
	$TextBox.editable = false
	dig1 = int(one_cnt + tenth_cnt/10 + hundredth_cnt/100)
	dig01 = int(tenth_cnt % 10 + (hundredth_cnt % 100)/10)
	dig1 = dig01/10 + dig1
	dig01 = dig01 % 10
	dig001 = int((hundredth_cnt % 100) % 10)
	var equal = true
	if new_text.length() > 1:
		if new_text[1] == "," or new_text[1] == ".":
			new_text[1] = "."
		else:
			equal = false	
	if equal:
		if stepify(float(new_text), 0.00001) != stepify(dig1*1.0 + dig01/10.0+dig001/100.0, 0.00001):
			equal = false
	if equal:
		read_only_box.bg_color = Color(0, 1, 0, 0.5)
		if score < score_max:
			if level < 4:
				level_counters[level][score].frame = 1
			score += 1
		if score == score_max and level < 3:
			level += 1
			score = 0
		$NewQuestion.start()
	else:
		read_only_box.bg_color = Color(1, 0, 0, 0.5)
		for i in range(score):
			level_counters[level][i].frame = 0
		score = 0
		$Next.show()
		
func _mk_new():
	one_cnt = 0
	tenth_cnt = 0
	hundredth_cnt = 0
	$TextBox.editable = true
	
	for list in [ones, tenths, hundredths, blank_tenths, blank_hundredths]:
		for element in list:
			element.queue_free()
	ones = []
	tenths = []
	hundredths = []
	blank_tenths = []
	blank_hundredths = []
	
	randomize()
	
	if level == 0 or level == 1:
		one_cnt = randi() % 2
	else:
		one_cnt = randi() % 4
		
	for i in range(one_cnt):
		_mk_one(Vector2(xpositions[i], one_y))
	
	if level == 0 or level == 1:
		tenth_cnt = randi() % 10
	else:
		tenth_cnt = randi() % 40
		
	var cnt = -1
	for i in range(tenth_cnt / 10):
		var blank_tenth = blank_tenths_scene.instance()
		blank_tenth.position = Vector2(xpositions[i], tenth_y)
		add_child(blank_tenth)
		blank_tenths.append(blank_tenth)
		for j in range(10):
			_mk_tenth(Vector2(j*(tenth_size) - (one_size-tenth_size)/2 + xpositions[i], tenth_y))	
		cnt = i
	
	if (tenth_cnt % 10 != 0):
		var blank_tenth = blank_tenths_scene.instance()
		blank_tenth.position = Vector2(xpositions[cnt+1], tenth_y)
		add_child(blank_tenth)
		blank_tenths.append(blank_tenth)
		for j in range(tenth_cnt % 10):
			_mk_tenth(Vector2(j*(tenth_size) - (one_size-tenth_size)/2 + xpositions[cnt+1], tenth_y))	
	
	if level == 0 or level == 2:
		return one_cnt + tenth_cnt
		
	if level == 1:
		hundredth_cnt = randi() % 10
		
	if level == 3: 
		hundredth_cnt = randi() % 400
	
	cnt = -1	
	for i in range(hundredth_cnt / 100):
		var blank_hundredth = blank_hundredths_scene.instance()
		blank_hundredth.position = Vector2(xpositions[i], hundredth_y)
		add_child(blank_hundredth)
		blank_hundredths.append(blank_hundredth)
		for j in range(100):
# warning-ignore:integer_division
			_mk_hundredth(Vector2((j / 10)*tenth_size-(one_size-tenth_size)/2+ xpositions[i], hundredth_y -(j % 10)*(tenth_size)+(one_size-tenth_size)/2))
		cnt = i
		
	if (hundredth_cnt % 100 != 0):
		var blank_hundredth = blank_hundredths_scene.instance()
		blank_hundredth.position = Vector2(xpositions[cnt+1], hundredth_y)
		add_child(blank_hundredth)
		blank_hundredths.append(blank_hundredth)
		for j in range(hundredth_cnt % 100):
# warning-ignore:integer_division
			_mk_hundredth(Vector2((j / 10)*tenth_size-(one_size-tenth_size)/2+ xpositions[cnt+1], hundredth_y -(j % 10)*(tenth_size)+(one_size-tenth_size)/2))
	
	return one_cnt + tenth_cnt + hundredth_cnt
	
func _on_timeout():
	$TextBox.text = ""
	while _mk_new() == 0:
		pass

func _on_next_pressed():
	$TextBox.text = ""
	$Next.hide()
	while _mk_new() == 0:
		pass

func _ready():
	var header_one = ones_scene.instance()
	header_one.position = Vector2(xpositions[0],125)
	add_child(header_one)
	
	var equal_sign1 = Label.new()
	equal_sign1.set("custom_fonts/font", GlobalVariables.get_font(100))
	equal_sign1.set("custom_colors/font_color", Color(0,0,0))
	equal_sign1.text = "="
	equal_sign1.rect_position = header_one.position + Vector2(125, -65)
	add_child(equal_sign1)
	
	var equals1 = Label.new()
	equals1.set("custom_fonts/font", GlobalVariables.get_font(80))
	equals1.set("custom_colors/font_color", Color(0,0,0))
	equals1.text = "1"
	equals1.rect_position = equal_sign1.rect_position + Vector2(100, 10)
	add_child(equals1)
	
	var equal_sign2 = Label.new()
	equal_sign2.set("custom_fonts/font", GlobalVariables.get_font(100))
	equal_sign2.set("custom_colors/font_color", Color(0,0,0))
	equal_sign2.text = "="
	equal_sign2.rect_position = Vector2(xpositions[0], tenth_y) + Vector2(125, -65)
	add_child(equal_sign2)
	
	normal_box = StyleBoxFlat.new()
	normal_box.bg_color = Color(1, 1, 1)
	normal_box.border_color = Color(0, 0, 0)
	normal_box.border_width_bottom = 2
	normal_box.set_border_width_all(2)
	
	read_only_box = StyleBoxFlat.new()
	read_only_box.border_color = Color(0, 0, 0)
	read_only_box.border_width_bottom = 2
	read_only_box.set_border_width_all(2)
	$TextBox.set("custom_styles/read_only", read_only_box)
	$TextBox.set("custom_styles/normal", normal_box)
	$TextBox.set("custom_fonts/font", GlobalVariables.get_font(80))
	$TextBox.set("custom_colors/font_color", Color(0, 0, 0))
	$TextBox.rect_size = Vector2(100, 80)
	$TextBox.max_length = $TextBox.rect_size.x
	$TextBox.rect_position = equal_sign2.rect_position + Vector2(100, 10)
	
	for i in range(4):
		var level_label = GlobalVariables.get_label(30)
		level_label.text = "Level "+str(i+1)
		level_label.rect_position = Vector2(10, 10 + i*50)
		add_child(level_label)
		level_counters.append([])
		for j in range(score_max):
			var counter = counter_scene.instance()
			counter.position = Vector2(150 + j*30, 32 + 50*i)
			add_child(counter)
			level_counters[i].append(counter)
	
	while _mk_new() == 0:
		pass
	
	$Next.rect_position = $TextBox.rect_position + Vector2(300, 18)
	$Next.hide()
	
	assert($TextBox.connect("text_entered", self, "_on_text_entered") == 0)
	assert($NewQuestion.connect("timeout", self, "_on_timeout") == 0)
	assert($Next.connect("pressed", self, "_on_next_pressed") == 0)
