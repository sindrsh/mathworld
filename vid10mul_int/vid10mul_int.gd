extends "res://MulVideo.gd"

var y_intervals = 3.5
var times0
var times1
var times2
var times0b
var times1b
var times2b
var times0c
var times1c
var times2c
var equals0
var equals1
var equals2
var equals0b
var equals1b
var equals2b
var equals0c
var equals1c
var equals2c
var x_line1
var x_line2
var a0
var b0
var c0
var a0b
var b0b
var c0b
var a0c
var b0c
var c0c
var a1
var b1
var c1
var a1b
var b1b
var c1b
var a1c
var b1c
var c1c
var a2
var b2
var c2
var a2b
var b2b
var c2b
var a2c
var b2c
var c2c
var line1_a
var line1_b
var line1_c
var line2_a
var line2_b
var line2_c
var line3


func _ready():
	var font = DynamicFont.new()
	font.font_data = load("res://assets/fonts/OpenSans.ttf")
	font.size = 65
	var title = Label.new()
	title.add_font_override("font", font)
	title.add_color_override("font_color", Color(0, 0, 0))
	title.text = "Å gange med 10, 100 og 1000"
	title.rect_position = Vector2(500, 150) 
	add_child(title)
	num_scale = 0.7
	x_sep = 0.7*x_sep
	op_sep = 0.5*op_sep
	eq_sep = 0.6*eq_sep
	
	y_line_sep = 600
	
	pos0 = Vector2(150, 350)
	frame_max = 16

	a0 = mk_number("5", null, pos0)
	times0 = mk_operator(3,a0[-1].position+Vector2(op_sep,0))
	b0 = mk_number("10", null, times0.position + Vector2(op_sep, 0))
	equals0 = mk_operator(0,b0[-1].position+Vector2(eq_sep,0))
	c0 = mk_number("50", null, equals0.position + Vector2(eq_sep, 0))
	
	a0b = mk_number("27", null, Vector2(a0[-1].position.x-x_sep, pos0.y + y_sep))
	times0b = mk_operator(3,a0b[-1].position+Vector2(op_sep,0))
	b0b = mk_number("10", null, times0b.position + Vector2(op_sep, 0))
	equals0b = mk_operator(0,b0b[-1].position+Vector2(eq_sep,0))
	c0b = mk_number("270", null, equals0b.position + Vector2(eq_sep, 0))	
	
	a0c = mk_number("398", null, Vector2(a0[-1].position.x-2*x_sep, pos0.y + 2*y_sep))
	times0c = mk_operator(3,a0c[-1].position+Vector2(op_sep,0))
	b0c = mk_number("10", null, times0c.position + Vector2(op_sep, 0))
	equals0c = mk_operator(0,b0c[-1].position+Vector2(eq_sep,0))
	c0c = mk_number("3980", null, equals0c.position + Vector2(eq_sep, 0))		
	
	
	a1 = mk_number("5", null, Vector2(pos0.x + y_line_sep - x_sep, pos0.y))
	times1 = mk_operator(3,a1[-1].position+Vector2(op_sep, 0))
	b1 = mk_number("100", null, times1.position + Vector2(op_sep, 0))
	equals1 = mk_operator(0, b1[-1].position + Vector2(eq_sep, 0))
	c1 = mk_number("500", null, equals1.position + Vector2(eq_sep, 0))
	
	a1b = mk_number("27", null, Vector2(a1[-1].position.x-x_sep, pos0.y + y_sep))
	times1b = mk_operator(3,a1b[-1].position+Vector2(op_sep,0))
	b1b = mk_number("100", null, times1b.position + Vector2(op_sep, 0))
	equals1b = mk_operator(0,b1b[-1].position+Vector2(eq_sep,0))
	c1b = mk_number("2700", null, equals1b.position + Vector2(eq_sep, 0))	

	a1c = mk_number("398", null, Vector2(a1b[-2].position.x-x_sep, pos0.y + 2*y_sep))
	times1c = mk_operator(3,a1c[-1].position+Vector2(op_sep,0))
	b1c = mk_number("100", null, times1c.position + Vector2(op_sep, 0))
	equals1c = mk_operator(0,b1c[-1].position+Vector2(eq_sep,0))
	c1c = mk_number("39800", null, equals1c.position + Vector2(eq_sep, 0))	
	
	

	a2 = mk_number("5", null, Vector2(pos0.x + 2*y_line_sep, pos0.y))
	times2 = mk_operator(3,a2[-1].position+Vector2(op_sep, 0))
	b2 = mk_number("1000", null, times2.position + Vector2(op_sep, 0))
	equals2 = mk_operator(0, b2[-1].position + Vector2(eq_sep, 0))
	c2 = mk_number("5000", null, equals2.position + Vector2(eq_sep, 0))
	
	a2b = mk_number("27", null, Vector2(a2[-1].position.x-x_sep, pos0.y + y_sep))
	times2b = mk_operator(3,a2b[-1].position+Vector2(op_sep,0))
	b2b = mk_number("1000", null, times2b.position + Vector2(op_sep, 0))
	equals2b = mk_operator(0,b2b[-1].position+Vector2(eq_sep,0))
	c2b = mk_number("27000", null, equals2b.position + Vector2(eq_sep, 0))	
	
	a2c = mk_number("398", null, Vector2(a2b[-2].position.x-x_sep, pos0.y + 2*y_sep))
	times2c = mk_operator(3,a2c[-1].position+Vector2(op_sep,0))
	b2c = mk_number("1000", null, times2c.position + Vector2(op_sep, 0))
	equals2c = mk_operator(0,b2c[-1].position+Vector2(eq_sep,0))
	c2c = mk_number("398000", null, equals2c.position + Vector2(eq_sep, 0))		
	
	mk_frame_func_list()
	update()
	
func frame0():
	pass

func frame1():
	pass

func frame2():
	times0.visible = true
	equals0.visible = true	
	show_on_screen(a0)
	show_on_screen(b0)	
	show_on_screen(c0)	

func frame3():
	b0[-1].animation = "select"
	change_color(c0, "combine")
	c0[-1].animation = "select"
	change_color(a0, "combine")
	
func frame4():
	times0b.visible = true
	equals0b.visible = true
	show_on_screen(a0b)
	show_on_screen(b0b)	
	show_on_screen(c0b)	

func frame5():
	times0c.visible = true
	equals0c.visible = true
	show_on_screen(a0c)
	show_on_screen(b0c)	
	show_on_screen(c0c)			
	
		

func frame6():
	times1.visible = true
	equals1.visible = true
	show_on_screen(a1)
	show_on_screen(b1)	

func frame7():
	show_on_screen(a1)
	show_on_screen(b1)	
	show_on_screen(c1)	

func frame8():
	b1[-1].animation = "select"
	b1[-2].animation = "select"
	change_color(c1, "combine")
	c1[-1].animation = "select"
	c1[-2].animation = "select"	
	change_color(a1, "combine")	
	
func frame9():
	times1b.visible = true
	equals1b.visible = true
	show_on_screen(a1b)
	show_on_screen(b1b)	
	show_on_screen(c1b)		
	
func frame10():
	times1c.visible = true
	equals1c.visible = true
	show_on_screen(a1c)
	show_on_screen(b1c)	
	show_on_screen(c1c)		

func frame11():
	times2.visible = true
	equals2.visible = true
	show_on_screen(a2)
	show_on_screen(b2)	

func frame12():
	show_on_screen(c2)	

func frame13():
	b2[-1].animation = "select"
	b2[-2].animation = "select"
	b2[-3].animation = "select"	
	change_color(c2, "combine")
	c2[-1].animation = "select"
	c2[-2].animation = "select"	
	c2[-3].animation = "select"	
	change_color(a2, "combine")	

func frame14():
	times2b.visible = true
	equals2b.visible = true
	show_on_screen(a2b)
	show_on_screen(b2b)	
	show_on_screen(c2b)			

func frame15():
	times2c.visible = true
	equals2c.visible = true
	show_on_screen(a2c)
	show_on_screen(b2c)	
	show_on_screen(c2c)			
	
""""	

func frame10():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
"""
