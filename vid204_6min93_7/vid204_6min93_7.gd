extends "res://SubVideo.gd"

var y_intervals = 2.5
var minus
var equals
var x_line1
var x_line2
var line0
var line1_a
var line1_b
var line2_a
var line2_b
var line3_a
var line3_b
var line4_a
var line4_b
var line5

func frame0():
	pass

func frame1():
	minus.visible = true
		
	show_on_screen(a)
	show_on_screen(b)	

func frame2():
	change_color(b, "select")
	change_color(line0, "select")
	
	x_line1.visible = true
	show_on_screen(line0)	
		

func frame3():
	change_color(line1_a, "combine")
	change_color(line1_b, "result")	
	change_color(line0, "combine")
	
	show_on_screen(line1_a)	
	show_on_screen(line1_b)		

func frame4():
	change_color(line1_b, "combine")
	change_color(line2_a, "combine")
	change_color(line2_b, "result")	
	
	show_on_screen(line2_a)	
	show_on_screen(line2_b)	
	
func frame5():
	change_color(line2_b, "select")
	change_color(a, "select")

func frame6():
	change_color(line1_a, "combine")
	change_color(line2_a, "combine")
	change_color(line5, "result")	
	
	show_on_screen(line5)	
	x_line2.visible = true

func frame7():
	change_color(c, "select")
	change_color(line5, "select")
	
	show_on_screen(c)	
	equals.visible = true

func _ready():
	y_line_sep = y_line_sep + 2*comma_sep
	frame = 0
	frame_max = 8
	
	a = mk_number("204", "6", pos0)
	minus = mk_operator(2,a[-1].position+Vector2(op_sep,0))
	b = mk_number("93", "7", minus.position + Vector2(op_sep, 0))
	equals = mk_operator(0,b[-1].position+Vector2(op_sep,0))
	c = mk_number("110", "9", equals.position + Vector2(op_sep, 0))
	
	line0 = mk_number("93", "7", pos0b)
	
	x_line1 = sep_line_scene.instance()
	var y = line0[0].position.y
	var x1 = line0[1].position.x 	#align with one-placed digit
	var x2 = x1-y_line_sep-3*x_sep
	
	x_line1.points = PoolVector2Array(
		[Vector2(x2-3*x_sep,y+y_sep/2), Vector2(x1+2*x_sep, y+y_sep/2)]
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
	line1_a = mk_number("0", "9", Vector2(x2, y)) 
	line1_b = mk_number("94", "6", Vector2(x1-x_sep, y)) 
	
	y += y_sep
	line2_a = mk_number("110", null, Vector2(x2-2*x_sep, y)) 
	line2_b = mk_number("204", "6", Vector2(x1-2*x_sep, y)) 
		
	y += y_sep
	line5 = mk_number("110", "9", Vector2(x2-2*x_sep, y)) 
	
	for i in range(frame_max):
		if ResourceLoader.exists("res://sub2/audio/frame" + String(i) + ".mp3"):
			var audio_clip = load("res://sub2/audio/frame" + String(i) + ".mp3")
			audio_clip.loop = false
			streams.append(audio_clip)
		else: streams.append(null)
		
	mk_frame_func_list()
	update()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
