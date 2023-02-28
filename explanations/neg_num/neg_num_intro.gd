extends Node2D

var neg_num_scene : PackedScene = preload("res://assets/global_scenes/geo_shape.tscn")
var x_scale = 70
var pos_col = Color(0,0,1)
var dy = 40
var number_line : NumberLine

# Called when the node enters the scene tree for the first time.
func _ready():

	number_line = NumberLine.new()
	number_line.mk_x_axis(-12.0, 12.0, x_scale, true)
	number_line.position = Vector2(960, 700)
	add_child(number_line)
	_frame1()
	

func _frame1():
	var a : int = 3
	var b : int = 6
	var neg_num : GeoShape = neg_num_scene.instantiate()
	neg_num.mk_vec(a, 0, x_scale, pos_col)
	neg_num.position = number_line.position + Vector2(0, -dy)
	add_child(neg_num)
	
	var neg_num2 : GeoShape = neg_num_scene.instantiate()
	neg_num2.mk_vec(b, 0, x_scale, pos_col)
	neg_num2.position = number_line.position + Vector2(3*x_scale, -2*dy)
	add_child(neg_num2)
	
	var eq_string : String = str(a) + " + " + str(b) + " = " + str(a+b)
	var equation : Text = Text.new(70, eq_string)
	equation.set_text_position(number_line.position - Vector2(0, 200)) 
	add_child(equation)	
	
