extends "res://MulVideo.gd"

var y_intervals = 3.5
var times0
var times1
var times2
var times0b
var times1b
var times0c
var times1c
var equals0
var equals1
var equals2
var equals0b
var equals1b
var equals0c
var equals1c
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
var line1_a
var line1_b
var line1_c
var line2_a
var line2_b
var line2_c
var line3


func _ready():

	y_line_sep = 900
	y_sep = 200
	
	pos0 = Vector2(200, pos0.y+60)
	frame_max = 11

	a0 = mk_number("7", null, pos0)
	times0 = mk_operator(3,a0[-1].position+Vector2(op_sep,0))
	b0 = mk_number("20", null, times0.position + Vector2(op_sep, 0))
	equals0 = mk_operator(0,b0[-1].position+Vector2(eq_sep,0))
	c0 = mk_number("140", null, equals0.position + Vector2(eq_sep, 0))
	
	a0b = mk_number("3", null, Vector2(a0[0].position.x, pos0.y + y_sep))
	times0b = mk_operator(3,a0b[-1].position+Vector2(op_sep,0))
	b0b = mk_number("60", null, times0b.position + Vector2(op_sep, 0))
	equals0b = mk_operator(0,b0b[-1].position+Vector2(eq_sep,0))
	c0b = mk_number("180", null, equals0b.position + Vector2(eq_sep, 0))	
	
	a0c = mk_number("5", null, Vector2(a0[0].position.x, pos0.y + 2*y_sep))
	times0c = mk_operator(3,a0c[-1].position+Vector2(op_sep,0))
	b0c = mk_number("80", null, times0c.position + Vector2(op_sep, 0))
	equals0c = mk_operator(0,b0c[-1].position+Vector2(eq_sep,0))
	c0c = mk_number("400", null, equals0c.position + Vector2(eq_sep, 0))		
	
	
	a1 = mk_number("6", null, Vector2(pos0.x + y_line_sep, pos0.y))
	times1 = mk_operator(3,a1[-1].position+Vector2(op_sep, 0))
	b1 = mk_number("700", null, times1.position + Vector2(op_sep, 0))
	equals1 = mk_operator(0, b1[-1].position + Vector2(eq_sep, 0))
	c1 = mk_number("4200", null, equals1.position + Vector2(eq_sep, 0))
	
	a1b = mk_number("9", null, Vector2(a1[-1].position.x, pos0.y + y_sep))
	times1b = mk_operator(3,a1b[-1].position+Vector2(op_sep,0))
	b1b = mk_number("300", null, times1b.position + Vector2(op_sep, 0))
	equals1b = mk_operator(0,b1b[-1].position+Vector2(eq_sep,0))
	c1b = mk_number("2700", null, equals1b.position + Vector2(eq_sep, 0))	
	
	a1c = mk_number("5", null, Vector2(a1b[0].position.x, pos0.y + 2*y_sep))
	times1c = mk_operator(3,a1c[-1].position+Vector2(op_sep,0))
	b1c = mk_number("400", null, times1c.position + Vector2(op_sep, 0))
	equals1c = mk_operator(0,b1c[-1].position+Vector2(eq_sep,0))
	c1c = mk_number("2000", null, equals1c.position + Vector2(eq_sep, 0))	
	
	mk_frame_func_list()
	update()
	
func frame0():
	pass

func frame1():
	times0.visible = true
	equals0.visible = true
	show_on_screen(a0)
	show_on_screen(b0)	

func frame2():
	times0.visible = true
	equals0.visible = true	
	show_on_screen(a0)
	show_on_screen(b0)	
	show_on_screen(c0)	

func frame3():
	change_color(b0, "combine")
	b0[-1].animation = "select"
	change_color(c0, "result")
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
	change_color(b1, "combine")
	b1[-1].animation = "select"
	b1[-2].animation = "select"
	change_color(c1, "result")
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

	
	
