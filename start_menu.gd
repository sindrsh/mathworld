extends Node2D

var mini_game_button_scene = preload("res://mini_game_choice.tscn")

func _mk_button(scene : String, game : String, pos : Vector2i) -> void: 
	var dx : int = 90
	var dy : int = 100
	var start_pos = Vector2(50,50)
	
	var button : Button = mini_game_button_scene.instantiate()
	button.scene = scene
	button.text = game
	button.position = start_pos + Vector2((button.size.x + dx)*pos.x, dy*pos.y)
	add_child(button)

func _ready() -> void:
	
	_mk_button("uid://cvkgs7sjol1ex", "Ordering", Vector2i(0,0))
	_mk_button("uid://bdpib7i2a1rqg", "match the numbers", Vector2i(1,0))
	
	_mk_button("uid://bddx2q5bjqo73", "fraction bridge", Vector2i(0,2))
	_mk_button("uid://bksrxe17w20ux", "frac_bridge 2", Vector2i(1,2))
	_mk_button("uid://bg0qhhfmqp68r", "fraction laser*", Vector2i(2,2))
	_mk_button("uid://clancf4lw213r", "match the fractions", Vector2i(3,2))
	_mk_button("uid://puk4go41bcos", "match the values", Vector2i(4,2))

	_mk_button("uid://b756fj2codywv", "Pytagoras puzzle*", Vector2i(0,4))

	var info_text = Text.new(20, "* indicates games with no ending and/or score")
	info_text.position = Vector2(50, 700)
	add_child(info_text)
