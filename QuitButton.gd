extends Button

func _on_pressed() -> void:
	get_tree().exit()

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", _on_pressed)
