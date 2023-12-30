extends TextureButton

signal released

var mouse_offset : Vector2
var active : bool = false
var centered := true
var texture_size_div2 : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(connect("button_down", _on_button_down) == 0)
	assert(connect("button_up", _on_button_up) == 0)


func _on_button_down() -> void:
	mouse_offset = global_position - get_global_mouse_position()
	active = true
	
	
func _on_button_up() -> void:
	active = false
	emit_signal("released")


func set_txture_normal(txture : Texture2D) -> void:
	texture_normal = txture
	texture_size_div2 = texture_normal.get_size()/2.0
	if centered:
		position = -Vector2(texture_size_div2.x, texture_size_div2.y)


func scale_and_modulate(_scale: Vector2) -> void:
	scale = _scale
	self_modulate = Color(1, 1, 1, 0)
	if centered:
		position = -scale*Vector2(texture_size_div2.x, texture_size_div2.y)		
	
# This function should be implemented in
# the parent scene:
"""
func _process(_delta):
	if active:
		position = get_global_mouse_position() + mouse_offset + texture_size_div2
"""
