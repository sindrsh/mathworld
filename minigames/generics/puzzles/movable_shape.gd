extends TextureButton

var mouse_offset : Vector2
var active : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(connect("button_down", _on_button_down) == 0)
	assert(connect("button_up", _on_button_up) == 0)
#	set_anchors_preset(PRESET_CENTER)


func _on_button_down() -> void:
	mouse_offset = global_position - get_global_mouse_position()
	active = true
	
	
func _on_button_up() -> void:
	active = false



# This function should be implemented in
# the parent scene:
"""
func _process(_delta):
	if active:
		position = get_global_mouse_position() + mouse_offset
"""
