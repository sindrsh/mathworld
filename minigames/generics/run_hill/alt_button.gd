extends TextureButton

signal chosen(_name : String)

var value : int

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(pressed.connect(_button_pressed) == 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _button_pressed() -> void:
	emit_signal("chosen", name)
