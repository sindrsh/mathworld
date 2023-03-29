extends Button

func _ready():
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	get_tree().quit()
