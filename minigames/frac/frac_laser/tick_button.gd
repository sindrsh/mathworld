extends Button

var pressed_once = false
var index : int
signal send_laser

func _on_pressed():
	pressed_once = true
	emit_signal("send_laser", index)

func _ready():
	assert(connect("pressed", _on_pressed) == 0)


