extends Node2D

var video_button_scene = preload("res://VideoMenuButton.tscn")
var line_scene = preload("res://SepLine.tscn")
var lang_choice_scene = preload("res://LangButton.tscn")

var x_sep = 350
var y_sep = 150
var x_line_a = 100
var x_line_b = 1500
var x_line_y = 75

var sub_scene1
var sub_scene2
var sub_scene3

var vid10mul_int
var vid10mul_int_b
var mul_scene1

var div_scene1
var div_scene2

var dec_scene1

var dec_game

var y_line
var x_line1
var x_line2
var x_line3
var x_line4

var lang_choice


func _ready():
	sub_scene1 = video_button_scene.instance()
	sub_scene2 = video_button_scene.instance()
	sub_scene3 = video_button_scene.instance()	
	
	mul_scene1 = video_button_scene.instance()
	vid10mul_int = video_button_scene.instance()
	vid10mul_int_b = video_button_scene.instance()	
	
	div_scene1 = video_button_scene.instance()
	div_scene2 = video_button_scene.instance()
	
	dec_scene1 = video_button_scene.instance()
	
	dec_game = video_button_scene.instance()
	
	y_line = line_scene.instance()
	
	lang_choice = lang_choice_scene.instance()

	add_child(sub_scene1)
	add_child(sub_scene2)
	add_child(sub_scene3)	

	add_child(vid10mul_int)
	add_child(vid10mul_int_b)	
	add_child(mul_scene1)

	add_child(div_scene1)
	add_child(div_scene2)
	
	add_child(dec_scene1)
	add_child(dec_game)
	
	add_child(y_line)
	
	add_child(lang_choice)
	
	
	sub_scene1.scene = "res://vid134min87/vid134min87.tscn"
	sub_scene1.rect_position = Vector2(400,100)

	sub_scene2.scene = "res://vid801min512/vid801min512.tscn"
	sub_scene2.rect_position = sub_scene1.rect_position + Vector2(x_sep, 0)

	sub_scene3.scene = "res://vid204_6min93_7/vid204_6min93_7.tscn"
	sub_scene3.rect_position = sub_scene2.rect_position + Vector2(x_sep, 0)
	
	
	vid10mul_int.scene = "res://vid10mul_int/vid10mul_int.tscn"
	vid10mul_int.rect_position = Vector2(400,250)
	
	vid10mul_int_b.scene = "res://vid10mul_int_b/vid10mul_int_b.tscn"
	vid10mul_int_b.rect_position = vid10mul_int.rect_position + Vector2(x_sep, 0)
		
	mul_scene1.scene = "res://vid26mul3/vid26mul3.tscn"
	mul_scene1.rect_position = vid10mul_int_b.rect_position + Vector2(x_sep, 0)
	
	div_scene1.scene = "res://vid72div4/vid72div4.tscn"
	div_scene1.rect_position = Vector2(400,400)

	div_scene2.scene = "res://vid718div2/vid718div2.tscn"
	div_scene2.rect_position = div_scene1.rect_position + Vector2(x_sep, 0)
	
	lang_choice.rect_position = Vector2(1600, 22)
	
	dec_scene1.scene = "res://vid_dec/vid_dec.tscn"
	dec_scene1.rect_position = Vector2(400,550)
	
	dec_game.scene = "res://minigames/falling_decimals/Main.tscn"
	dec_game.rect_position = Vector2(400, 800)
	dec_game.text = "MINIGAME"
	
	
	_on_lang_change()
	
	


func _on_lang_change():
	var lang = PlayerVariables.menu_lang[PlayerVariables.current_lang]
	
	sub_scene1.text = lang.eg + " 1"
	sub_scene2.text = lang.eg + " 2"
	sub_scene3.text = lang.eg + " 3"
	
	vid10mul_int.text = lang.eg + " 1"
	vid10mul_int_b.text = lang.eg + " 2"
	
	mul_scene1.text = lang.eg + " 3"
	div_scene1.text = lang.eg + " 1"
	div_scene2.text = lang.eg + " 2"
	
	dec_scene1.text = lang.eg + " 1"


func _draw():
	var table_col = Color(0, 0, 0)
	var table_width = 5
	
	draw_line(Vector2(350, 75), Vector2(350, 675), table_col, table_width, true)
	
	for i in range(5):
		draw_line(Vector2(x_line_a,x_line_y + i*y_sep), Vector2(x_line_b,x_line_y + i*y_sep), table_col, table_width, true)
