extends Label
class_name Text

var string_size : Vector2
var font : Font:
	set(_font):
		font = _font
		set("theme_override_fonts/font", font)
		
var font_size : int:
	set(_font_size):
		font_size = _font_size
		set("theme_override_font_sizes/font_size", font_size)


func _init(font_sz : int = 40, txt : String = "", font_color : Color = Color(0, 0, 0)):
	font_size = font_sz
	font = load("res://assets/fonts/OpenSans.ttf")
#	set("theme_override_fonts/font", font)
#	set("theme_override_font_sizes/font_size", font_sz)
	set("theme_override_colors/font_color", font_color)
	set_new_text(txt)
	

func _ready():	
	if not font:
		set("theme_override_fonts/font", font)
		set("theme_override_colors/font_color", Color(0, 0, 0))

func set_new_text(new_text : String):
	text = new_text
	string_size = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
	
func set_text_position(pos : Vector2, adjust : Vector2 = Vector2(-0.5, 0)) -> void:
	position = pos + string_size*adjust

func center_text():
	set_text_position(Vector2(0,0), Vector2(-0.5, -0.5))
	


