extends LineEdit

var read_only_box_correct = StyleBoxFlat.new()
var read_only_box_incorrect = StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	assert($EnterButton.pressed.connect(_on_enter_button_pressed) == 0)
	
	read_only_box_correct.bg_color = Color(0,1,0.5)
	read_only_box_correct.set_border_width_all(4)
	read_only_box_correct.border_color = Color(0,0,0)
	set("theme_override_styles/read_only", read_only_box_correct) 
	
	read_only_box_incorrect.bg_color = Color(1,0,0.5)
	read_only_box_incorrect.set_border_width_all(4)
	read_only_box_incorrect.border_color = Color(0,0,0)
	
	$EnterButton.size = Vector2(size.y, size.y)
	$EnterButton.position = Vector2(size.x, 0)
	
	
func set_new_size(new_size : Vector2) -> void:
	size = new_size
	$EnterButton.position = Vector2(size.x, 0)
	

func _on_enter_button_pressed():
	emit_signal("text_submitted", text)
