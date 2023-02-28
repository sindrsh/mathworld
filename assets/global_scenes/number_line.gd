extends Node2D
class_name NumberLine

var x_axis : Node2D
var tick_list : Array = []

func mk_x_tick(pos : Vector2, txt : String ="", dy : float = 1, colr : Color = Color(0,0,0), font_size : int = 40, 
				width : float = 7.0, length : float = 15.0) -> void:
	var tick : Line2D = Line2D.new()
	tick.points = PackedVector2Array([
		Vector2(0,length),
		Vector2(0,-length),		
	])
	tick.width = width
	tick.position = pos	
	tick.default_color = colr
	tick_list.append(tick)
	add_child(tick)
	
	if not txt.is_empty():
		var tick_label : Text = Text.new(font_size, txt)
		tick_label.set_text_position(tick.position + Vector2(0, dy*15))
		add_child(tick_label)


func mk_x_axis(x_start : float, x_end : float, x_scale : float = 1, int_ticks : bool = false,
			width : float = 7.0, _end_arrow : bool = false, _start_arrow : bool = false) -> void:
	x_axis = Line2D.new()
	x_axis.points = PackedVector2Array([
		Vector2(x_scale*x_start, 0),
		Vector2(x_scale*x_end, 0),
	])
	x_axis.width = width
	x_axis.default_color= Color(0,0,0)
	add_child(x_axis)
	
	if int_ticks:
		assert(int(x_start) == snapped(x_start, 0.0001))
		assert(int(x_end) == snapped(x_end, 0.0001)) 
		@warning_ignore("integer_division")
		for i in range(x_end-x_start + 1):
			mk_x_tick(x_axis.position + Vector2(x_start*x_scale + x_scale*i, 0), str(int(x_start)+i))


