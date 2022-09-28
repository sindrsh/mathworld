extends Node


func get_font(size = 16):
	var font = DynamicFont.new()
	font.font_data = load("res://assets/fonts/OpenSans.ttf")
	font.size = size
	return font

func get_label(size = 16, color = Color(0, 0, 0)):
	var font = get_font(size)
	var labl = Label.new()
	labl.set("custom_fonts/font", font)
	labl.set("custom_colors/font_color", color)
	return labl

func mk_operator(int_frame, pos, num_scale = 1):
	var op_scene = preload("res://Operator.tscn")
	var op = op_scene.instance()
	op.scale = num_scale*Vector2(1, 1)
	op.frame = int_frame
	op.position = pos
	add_child(op)
	return op

func mk_number(number, decs, pos, num_scale = 1, x_sep = 20, comma_sep = 20, comma_sep2 = 5, comma_y = 5):
	var num_scene = preload("res://Int.tscn")
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
		comma = GlobalVariables.mk_operator(5, pos + Vector2(cnt*x_sep - comma_sep, comma_y), num_scale)
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
