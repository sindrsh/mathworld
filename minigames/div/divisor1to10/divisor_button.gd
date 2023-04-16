extends Button

signal divisor_button_pressed(_name : String)

# Called when the node enters the scene tree for the first time.
func _init():
	assert(pressed.connect(_on_pressed) == 0)


func _on_pressed():
	emit_signal("divisor_button_pressed", name)

