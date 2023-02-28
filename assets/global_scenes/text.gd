extends Label
class_name Text

var string_size : Vector2
var font : Font
var font_size

func set_new_text(new_text : String):
	text = new_text
	string_size = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
	
func set_text_position(pos : Vector2, adjust : Vector2 = Vector2(-0.5, 0)) -> void:
	position = pos + string_size*adjust

func _init(font_sz : int, txt : String, font_color : Color = Color(0, 0, 0)):
	font_size = font_sz
	font = load("res://assets/fonts/OpenSans.ttf")
	set("thene_override_fonts/font", font)
	set("theme_override_font_sizes/font_size", font_sz)
	set("theme_override_colors/font_color", font_color)
	set_new_text(txt)
