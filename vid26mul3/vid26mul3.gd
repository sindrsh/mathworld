extends "res://MulVideo.gd"

var y_intervals = 2.5
var times0
var times1
var times2
var equals0
var equals1
var equals2
var x_line1
var x_line2
var a
var b
var c
var line1_a
var line1_b
var line1_c
var line2_a
var line2_b
var line2_c
var line3


func _ready():
	frame = 0
	frame_max = 6

	a = mk_number("26", null, pos0)
	times0 = mk_operator(3,a[-1].position+Vector2(op_sep,0))
	b = mk_number("3", null, times0.position + Vector2(op_sep, 0))
	equals0 = mk_operator(0,b[-1].position+Vector2(eq_sep,0))
	c = mk_number("78", null, equals0.position + Vector2(eq_sep, 0))	
	
	x_line1 = sep_line_scene.instance()
	
	var y = a[0].position.y
	
	x_line1.points = PoolVector2Array(
		[Vector2(a[0].position.x-x_sep,y+(y_sep+y_sep2)/2), Vector2(c[-1].position.x+x_sep, y+(y_sep+y_sep2)/2)]
	)
	add_child(x_line1)
	view_list.append(x_line1)
	
	x_line2 = sep_line_scene.instance()
	x_line2.points = PoolVector2Array(
		[Vector2(x_line1.points[0].x,y+y_intervals*y_sep+y_sep2), Vector2(x_line1.points[1].x, y+y_intervals*y_sep+y_sep2)]
	)
	add_child(x_line2)
	view_list.append(x_line2)
	
	y += y_sep + y_sep2
	line1_a = mk_number("20", null, Vector2(pos0.x, y))
	times1 = mk_operator(3,Vector2(times0.position.x,y))
	line1_b = mk_number("3", null, Vector2(b[-1].position.x, y))
	equals1 = mk_operator(0,Vector2(equals0.position.x,y))
	line1_c = mk_number("60", null,  Vector2(equals0.position.x+eq_sep, y))
	
	y += y_sep
	line2_a = mk_number("6", null, Vector2(pos0.x + x_sep, y))
	times2 = mk_operator(3,Vector2(times0.position.x,y))
	line2_b = mk_number("3", null, Vector2(b[-1].position.x, y))
	equals2 = mk_operator(0,Vector2(equals0.position.x,y))
	line2_c = mk_number("18", null,  Vector2(equals0.position.x+eq_sep, y))	
	
	y += y_sep
	line3 = mk_number("78", null,  Vector2(equals0.position.x+eq_sep, y))
	
	for i in range(frame_max):
		if ResourceLoader.exists("res://sub2/audio/frame" + String(i) + ".mp3"):
			var audio_clip = load("res://sub2/audio/frame" + String(i) + ".mp3")
			audio_clip.loop = false
			streams.append(audio_clip)
			
		else: streams.append(null)
	mk_frame_func_list()
	update()
	
func frame0():
	pass

func frame1():
	times0.visible = true
	equals0.visible = true
	show_on_screen(a)
	show_on_screen(b)	


func frame2():
	var orig_frame = a[0].frame
	a[0].animation = "combine"
	a[0].frame = orig_frame
	change_color(line1_a, "combine")
	
	times1.visible = true
	equals1.visible = true
	show_on_screen(line1_a)		
	show_on_screen(line1_b)	
	show_on_screen(line1_c)			

func frame3():
	var orig_frame = a[1].frame
	a[1].animation = "combine"
	a[1].frame = orig_frame
	change_color(line2_a, "combine")
	
	times2.visible = true
	equals2.visible = true
	show_on_screen(line2_a)		
	show_on_screen(line2_b)	
	show_on_screen(line2_c)	

func frame4():
	
	change_color(line1_c, "combine")
	change_color(line2_c, "combine")
	change_color(line3, "result")
	
	x_line2.visible = true
	show_on_screen(line3)	

func frame5():
	change_color(line3, "select")
	change_color(c, "select")
	
	show_on_screen(c)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
