extends Area2D

var num_scene = preload("res://Int.tscn")
var op_scene = preload("res://Operator.tscn")

var x_sep = 20
var op_sep = 70
var comma_sep = 5
var comma_sep2 = 10
var comma_y = 10
var num_scale = 0.5
var pos = Vector2(100,100)

# NOTE: mk_operator and mk_number should be made a generic autoload function
# as VideoPlayer.gd also use these functions

func mk_operator(int_frame, pos):
	var op = op_scene.instance()
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
		var dig = num_scene.instance()
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
			var dig = num_scene.instance()
			dig.scale = num_scale*Vector2(1, 1)
			dig.position = pos + Vector2(cnt*x_sep + comma_sep2, 0)
			dig.frame = int(digit)
			cnt += 1
			add_child(dig)
			num_list.append(dig)
	return num_list

func _ready():
	mk_number("2", "5", pos-Vector2(14,6))
	$NumberSprite.position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
