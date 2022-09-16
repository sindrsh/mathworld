extends Node2D

var num_scene = preload("res://Int.tscn")
var op_scene = preload("res://Operator.tscn")
var next_frame_scene = preload("res://ChangeFrame.tscn")
var prev_frame_scene = preload("res://ChangeFrame.tscn")
var audio_choice_scene = preload("res://AudioChoice.tscn")
var slideshow_choice_scene = preload("res://SlideshowChoice.tscn")
var textbox_choice_scene = preload("res://TextChoice.tscn")
var to_menu_scene  = preload("res://ToMenuButton.tscn")
var audio_player = AudioStreamPlayer.new()
var textbox_scene = preload("res://TextBox.tscn")
var lang_choice_scene = preload("res://LangButton.tscn")

var langs = ["no", "en", "ukr"]
var language = langs[0] setget set_language
var x_sep = 50
var op_sep = 70
var y_sep = 150
var y_line_sep = 100
var comma_sep = 20
var comma_sep2 = 5
var comma_y = 40
var num_scale = 1

var forwards = true
var backwards = false

var view_list = []
var frame_func_list = []

var next_frame
var prev_frame
var audio_choice
var slideshow_choice
var textbox_choice
var lang_choice
var streams = []
var texts = []
var top_bar
var textbox

var frame = 0
var frame_max setget set_frame_max
var audio_on = false
var slideshow_on = false
var textbox_on = false
enum {OFF, ON}

func update():
	for element in view_list:
		element.visible = false
		
	for i in range(frame_func_list.size()):
		if i > frame: break
		clear_colors()
		frame_func_list[i].call_func()	

func shift_frame(forward):
	if forward:
		if frame < frame_max-1:
			frame += 1
	else: 
		if frame > 0:
			frame -= 1	
	update()	
	
	if audio_on:
		audio_player.stream = streams[frame]
		if audio_player.stream != null:
			if not audio_player.is_playing(): audio_player.play()
	
	if textbox_on: textbox.get_node("Text").texture = texts[frame]


func mk_operator(int_frame, pos):
	var op = op_scene.instance()
	op.scale = num_scale*Vector2(1, 1)
	op.frame = int_frame
	op.position = pos
	add_child(op)
	view_list.append(op)
	return op
	
func mk_number(number, decs, pos):
	var num_list = []
	var comma
	var cnt = 0
	for digit in number:
		var dig = num_scene.instance()
		dig.scale = num_scale*Vector2(1, 1)
		dig.position = pos + Vector2(cnt*x_sep, 0)
		dig.frame = int(digit)
		cnt += 1
		add_child(dig)
		num_list.append(dig)
		view_list.append(dig)
	if decs != null:
		comma = mk_operator(6, pos + Vector2(cnt*x_sep - comma_sep, comma_y))
		num_list.append(comma)
		for digit in decs:
			var dig = num_scene.instance()
			dig.position = pos + Vector2(cnt*x_sep + comma_sep2, 0)
			dig.frame = int(digit)
			cnt += 1
			add_child(dig)
			num_list.append(dig)
			view_list.append(dig)
	return num_list

func change_color(num_list, color):
	for digit in num_list:
		var i = digit.frame
		digit.animation = color
		digit.frame = i

func clear_colors():
	for element in view_list:
		if element.is_class("AnimatedSprite"):
			var i = element.frame
			element.animation = "black"
			element.frame = i

func show_on_screen(num_list):
	for digit in num_list:
		digit.visible = true

func _on_next_pressed():
	shift_frame(forwards)
	
func _on_prev_pressed():
	shift_frame(backwards)
		
func _on_audio_pressed():
	audio_on = audio_on != true
	_update_audio_icon()
	
func _update_audio_icon():
	if audio_on:
		audio_choice.get_node("On_or_off").frame = ON
	else:
		audio_choice.get_node("On_or_off").frame = OFF	

func _on_slideshow_pressed():
	slideshow_on = slideshow_on != true
	audio_on = true
	_update_audio_icon()
	if slideshow_on:
		slideshow_choice.get_node("On_or_off").frame = ON
		if frame == 0: 
			shift_frame(forwards)
	else:
		slideshow_choice.get_node("On_or_off").frame = OFF
		audio_on = false
		_update_audio_icon()

func _on_textbox_pressed():
	textbox_on = textbox_on != true
	textbox.visible = textbox_on
	if textbox_on:
		textbox_choice.get_node("On_or_off").frame = ON
	else:
		textbox_choice.get_node("On_or_off").frame = OFF

func _on_audio_finished():
	if slideshow_on and frame != frame_max-1:
		shift_frame(forwards)

func _on_lang_selection(index):
	set_language(langs[index])
	lang_choice.icon.set_current_frame(index) 


# make list of callable frame functions		
func mk_frame_func_list(): 
	for i in range(frame_max):
		var f = funcref(self, "frame"+String(i))
		frame_func_list.append(f)

func set_language(selected_language):
	language = selected_language
	streams = []
	texts = []
	mk_streams_and_texts()

func set_frame_max(new_frame_max):
	frame_max = new_frame_max
	mk_streams_and_texts()

func mk_streams_and_texts():
	for i in range(frame_max):
		var audio_string = "res://" + self.get_name() + "/audio/frame" + String(i) +"_"+ language + ".mp3"
		if ResourceLoader.exists(audio_string):
			var audio_clip = load(audio_string)
			audio_clip.loop = false
			streams.append(audio_clip)
		else: streams.append(null)
	
		var text_string = "res://" + self.get_name() + "/text/frame" + String(i) + "_" + language + ".png"
		if ResourceLoader.exists(text_string):
			texts.append(load(text_string))
		else: texts.append(null)	


func _ready():	
	top_bar = ColorRect.new()
	top_bar.rect_size = Vector2(1920,115)
	top_bar.color = Color(0.09,0.33, 0.5, 0.2)

	next_frame = next_frame_scene.instance()
	prev_frame = prev_frame_scene.instance()
	audio_choice = audio_choice_scene.instance()
	slideshow_choice = slideshow_choice_scene.instance()
	textbox_choice = textbox_choice_scene.instance()
	lang_choice = lang_choice_scene.instance()
	
	textbox = textbox_scene.instance()
	textbox.rect_size = Vector2(750,450)
	textbox.color = Color(1,1, 0.8, 1)
	textbox.rect_position = Vector2(100,400)
	textbox.visible = false
	textbox.get_node("Text").centered = false
	textbox.get_node("Text").position = Vector2(10,10)	
	
	
	next_frame.rect_position = Vector2(1100, 20)
	next_frame.flip_h = true 
	prev_frame.rect_position = Vector2(900, 20)
	audio_choice.rect_position = Vector2(650, 13.5)
	slideshow_choice.rect_position = Vector2(400, 20)
	textbox_choice.rect_position = Vector2(200,20)
	lang_choice.rect_position = Vector2(1600, 22)
	
	
	
	add_child(top_bar)
	add_child(next_frame)
	add_child(prev_frame)
	add_child(audio_choice)
	add_child(slideshow_choice)
	add_child(audio_player)
	add_child(to_menu_scene.instance())
	add_child(textbox)
	add_child(textbox_choice)
	add_child(lang_choice)
	
	# connect signals
	assert(next_frame.connect("pressed", self, "_on_next_pressed") == 0)
	assert(prev_frame.connect("pressed", self, "_on_prev_pressed") == 0)
	assert(audio_choice.connect("pressed", self, "_on_audio_pressed") == 0)
	assert(slideshow_choice.connect("pressed", self, "_on_slideshow_pressed") == 0)	
	assert(textbox_choice.connect("pressed", self, "_on_textbox_pressed") == 0)
	assert(audio_player.connect("finished", self, "_on_audio_finished") == 0)
	assert(lang_choice.get_popup().connect("index_pressed", self, "_on_lang_selection") == 0)	
