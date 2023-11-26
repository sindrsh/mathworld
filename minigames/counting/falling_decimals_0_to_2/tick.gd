extends Area2D

signal selected

var value
var hovered = false

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false
	
func _on_area_entered(area):
	get_parent().validate(area, self)
			
func _on_timeout():
	$Sprite2D.frame = 0

func _ready():
	assert(mouse_entered.connect(_on_mouse_entered) == 0)
	assert(mouse_exited.connect(_on_mouse_exited) == 0)
	assert(area_entered.connect(_on_area_entered) == 0)
	assert($ColorTimer.connect("timeout", _on_timeout) == 0)
	assert($TextureButton.pressed.connect(_on_pressed) == 0)
	
func _on_pressed() -> void:
	emit_signal("selected", self)
