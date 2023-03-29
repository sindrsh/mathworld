extends Button

func _on_pressed() -> void:
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		text = "WINDOW"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		text = "FULLSCREEN"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", _on_pressed)
