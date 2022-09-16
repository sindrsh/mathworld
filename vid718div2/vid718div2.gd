extends "res://DivVideo.gd"

var y_intervals = 3.5
var divided
var equals
var times
var x_line1
var x_line2
var a
var b
var c
var line0
var line1_a
var line1_b
var line1_c
var line2_a
var line2_b
var line2_c
var line3_a
var line3_b
var line3_c
var line4

func _ready():
	frame = 0
	frame_max = 12
	
	a = mk_number("718", null, pos0)
	divided = mk_operator(4,a[-1].position+Vector2(op_sep,0))
	b = mk_number("2", null, divided.position + Vector2(op_sep, 0))
	equals = mk_operator(0,b[-1].position+Vector2(op_sep,0))
	c = mk_number("359", null, equals.position + Vector2(op_sep, 0))
	line0 = mk_number("2", null, pos0a)
	times = mk_operator(3,line0[0].position+Vector2(-times_sep,0))
	
	x_line1 = sep_line_scene.instance()
	
	var y = line0[0].position.y
	var x1 = line0[-1].position.x
	var x2 = x1 + y_line_sep + 2*x_sep
	var x3 = x2 + y_line_sep + 2*x_sep
	
	x_line1.points = PoolVector2Array(
		[Vector2(x1 - 2*x_sep,y+y_sep/2), Vector2(x3 + x_sep, y+y_sep/2)]
	)
	add_child(x_line1)
	view_list.append(x_line1)
	
	x_line2 = sep_line_scene.instance()
	x_line2.points = PoolVector2Array(
		[Vector2(x_line1.points[0].x,y+y_intervals*y_sep), Vector2(x_line1.points[1].x, y+y_intervals*y_sep)]
	)
	add_child(x_line2)
	view_list.append(x_line2)	
	
	
	y += y_sep
	line1_a = mk_number("300", null, Vector2(x1-2*x_sep, y)) 
	line1_b = mk_number("600", null, Vector2(x2-x_sep, y)) 
	line1_c = mk_number("600", null, Vector2(x3, y)) 	
	
	y += y_sep
	line2_a = mk_number("50", null, Vector2(x1-x_sep, y)) 
	line2_b = mk_number("100", null, Vector2(x2-x_sep, y)) 
	line2_c = mk_number("700", null, Vector2(x3, y)) 	
	
	y += y_sep
	line3_a = mk_number("9", null, Vector2(x1, y)) 
	line3_b = mk_number("18", null, Vector2(x2, y)) 	
	line3_c = mk_number("58", null, Vector2(x3+x_sep, y)) 
	
	y += y_sep
	line4 = mk_number("359", null, Vector2(x1-2*x_sep, y)) 
	
	for i in range(frame_max):
		if ResourceLoader.exists("res://ad1/audio/frame" + String(i) + ".mp3"):
			var audio_clip = load("res://ad1/audio/frame" + String(i) + ".mp3")
			audio_clip.loop = false
			streams.append(audio_clip)
			
		else: streams.append(null)
	mk_frame_func_list()
	update()
	
func frame0():
	pass

func frame1():
	divided.visible = true
		
	show_on_screen(a)
	show_on_screen(b)	

func frame2():
	times.visible = true	
	
	change_color(b, "select")
	change_color(line0, "select")
	
	x_line1.visible = true
	show_on_screen(line0)	

func frame3():
	change_color(line0, "combine")
	change_color(line1_a, "combine")
	change_color(line1_b, "result")
	
	show_on_screen(line1_a)	
	show_on_screen(line1_b)	
	
func frame4():
	change_color(line1_b, "combine")
	change_color(line1_c, "result")	
	
	show_on_screen(line1_a)	
	show_on_screen(line1_b)	
	show_on_screen(line1_c)		
		
func frame5():
	change_color(line0, "combine")
	change_color(line2_a, "combine")
	change_color(line2_b, "result")		
	
	show_on_screen(line2_a)	
	show_on_screen(line2_b)	

func frame6():
	change_color(line1_c, "combine")
	change_color(line2_b, "combine")
	change_color(line2_c, "result")	

	show_on_screen(line2_c)		

func frame7():
	change_color(line0, "combine")
	change_color(line3_a, "combine")
	change_color(line3_b, "result")	

	show_on_screen(line3_a)	
	show_on_screen(line3_b)

func frame8():
	change_color(line2_c, "combine")
	change_color(line3_b, "combine")	
	change_color(line3_c, "result")	

	show_on_screen(line3_c)	

func frame9():
	change_color(a, "select")		
	change_color(line3_c, "select")	
	
	
func frame10():
	change_color(line1_a, "combine")
	change_color(line2_a, "combine")
	change_color(line3_a, "combine")	
	change_color(line4, "result")	
	x_line2.visible = true
	show_on_screen(line4)		

func frame11():
	change_color(line4, "select")	
	change_color(c, "select")		
	equals.visible = true
	show_on_screen(c)
