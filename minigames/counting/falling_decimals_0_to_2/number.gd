extends Node2D

signal selected

var num_scene = preload("res://minigames/counting/falling_decimals_0_to_2/int.tscn")
var op_scene = preload("res://minigames/counting/falling_decimals_0_to_2/operator.tscn")

var value
var speed = Vector2(2000, 30)
var tick
var find_tick = false

var x_sep = 20
var comma_sep = 5
var comma_sep2 = 10
var comma_y = 10
var num_scale = 0.5
var num_pos = Vector2(100,100)

var hovered = false
var is_exiting = false


# NOTE: mk_operator and mk_number should be made a generic autoload function
# as VideoPlayer.gd also use these functions
func mk_operator(int_frame, pos):
	var op = op_scene.instantiate()
	op.scale = num_scale*Vector2(1, 1)
	op.frame = int_frame
	op.position = pos
	add_child(op)
	return op

func mk_number(number, decs, pos):
	var num_list = []
	var comma
	var cnt = 0
	for digit in number:
		var dig = num_scene.instantiate()
		dig.scale = num_scale*Vector2(1, 1)
		dig.position = pos + Vector2(cnt*x_sep, 0)
		dig.frame = int(digit)
		cnt += 1
		add_child(dig)
		num_list.append(dig)
	if decs != null:
		comma = mk_operator(5, pos + Vector2(cnt*x_sep - comma_sep, comma_y))
		num_list.append(comma)
		for digit in decs:
			var dig = num_scene.instantiate()
			dig.scale = num_scale*Vector2(1, 1)
			dig.position = pos + Vector2(cnt*x_sep + comma_sep2, 0)
			dig.frame = int(digit)
			cnt += 1
			add_child(dig)
			num_list.append(dig)
	return num_list

func _on_timeout():
	queue_free()
	
func _on_mouse_entered():
	hovered = true
	
func _change_speed():
	speed = Vector2(speed.x, 1.4*speed.y)	

func _on_mouse_exited():
	hovered = false

func _input(event):
	if event is InputEventMouseButton:
		if hovered:
			emit_signal("selected", self)

func _ready():
	position = num_pos
	
	assert($MouseDetector.connect("mouse_entered", Callable(self, "_on_mouse_entered")) == 0)
	assert($MouseDetector.connect("mouse_exited", Callable(self, "_on_mouse_exited")) == 0)
	assert($ExitTimer.connect("timeout", Callable(self, "_on_timeout")) == 0)	


func _process(delta):
	if find_tick == true:
		var x1 = position.x
		var x2 = tick.position.x
		if abs(x1 - x2) > delta*speed.x:
			position.x = x1 - (x1-x2)/abs(x1-x2)*delta*speed.x
		else:
			position.x = x2
	else:
		if position.y > get_parent().line_a.y-10:
			if not is_exiting:
				get_parent().validate($TickDetector, null)
				is_exiting = true
	position.y += delta*speed.y
