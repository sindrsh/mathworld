extends Node2D
class_name FracLabel

var a : Text
var b : Text
var bar : Line2D
var dy : int = 4
var size : int
var half_larger_text_size: float

func left_aligned() -> void:
	bar.position.x = bar.position.x + half_larger_text_size
	a.position.x = a.position.x + half_larger_text_size
	b.position.x = b.position.x + half_larger_text_size
	

func _init(a_string : String, b_string : String, font_size : int = 20) -> void:
	a = Text.new(font_size, a_string)
	b = Text.new(font_size, b_string)
	
	bar = Line2D.new()
	bar.width = 5
	bar.default_color = Color(0,0,0)

	var m = a
	var n = b
	var a_adjust = 0
	var b_adjust = 1
	if a.text.length() < b.text.length():
		m = b
		n = a
		a_adjust = 1
		b_adjust = 0
	var vertical_adjust = (m.string_size.x - n.string_size.x)/2.0
	bar.points = PackedVector2Array([Vector2(-m.string_size.x/2, 0), Vector2(m.string_size.x/2, 0)])
	a.position = bar.points[0] + Vector2(a_adjust*vertical_adjust, - a.string_size.y)
	b.position = bar.points[0] + Vector2(b_adjust*vertical_adjust, 0)	
	add_child(a)
	add_child(b)
	add_child(bar)
	half_larger_text_size = m.string_size.x/2
