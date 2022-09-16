extends Button

var font

func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://assets/fonts/OpenSans.ttf")
	set("custom_fonts/font", font)
