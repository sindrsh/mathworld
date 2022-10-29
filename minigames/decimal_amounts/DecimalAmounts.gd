extends Node2D

var ones_scene = preload("res://minigames/decimal_amounts/One1.tscn")
var tenths_scene = preload("res://minigames/decimal_amounts/One10th.tscn")
var hundredths_scene = preload("res://minigames/decimal_amounts/One100th.tscn")
var blank_tenths_scene = preload("res://minigames/decimal_amounts/BlankTenths.tscn")
var blank_hundredths_scene = preload("res://minigames/decimal_amounts/BlankHundredths.tscn")
var ones = []
var tenths = []
var hundredths = []

var one_digit
var tenth_digit
var hundredth_digit

var one_size = 200
var tenth_size = one_size/10

var ones_pos = Vector2(125, 400)

var one_sep = 10

var one_y = 200

var blank1_pos = ones_pos + Vector2(4*(one_size+one_sep), one_size + 20)
var blank2_pos = blank1_pos + Vector2(0, one_size + 20)

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
	draw_line(Vector2(50, 200), Vector2(1800, 200), Color(0, 0, 0), 5, true)

func _on_text_entered(new_text):
	print(new_text)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	one_digit = randi() % 10
	
	$TextBox.set("custom_fonts/font", GlobalVariables.get_font(60))
	$TextBox.set("custom_colors/font_color", Color(0, 0, 0))
	$TextBox.rect_size = Vector2(100, 80)
	$TextBox.max_length = $TextBox.rect_size.x
	$TextBox.rect_position = Vector2(700, 100)
	
	
	print($TextBox.rect_size.y)
	
	for i in range(one_digit):
		_mk_one(ones_pos + Vector2(i*(one_size+one_sep), 0))
	
	var blank_tenths = blank_tenths_scene.instance()
	blank_tenths.position = blank1_pos
	add_child(blank_tenths)
	
	tenth_digit = randi() % 10
	for i in range(tenth_digit):
		_mk_tenth(blank1_pos + Vector2(i*(tenth_size) - (one_size-tenth_size)/2, 0))	

	var blank_hundreths = blank_hundredths_scene.instance()
	blank_hundreths.position = blank2_pos
	add_child(blank_hundreths)
	
	hundredth_digit = randi() % 10
	for i in range(hundredth_digit):
# warning-ignore:integer_division
		_mk_hundredth(blank2_pos + Vector2((i / 10)*tenth_size-(one_size-tenth_size)/2, -(i % 10)*(tenth_size)+(one_size-tenth_size)/2))	
	
	assert($TextBox.connect("text_entered", self, "_on_text_entered") == 0)


