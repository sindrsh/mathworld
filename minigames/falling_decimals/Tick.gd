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

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if hovered:
			emit_signal("selected", self)
			
func _on_timeout():
	$Sprite.frame = 0

func _ready():
	assert(connect("mouse_entered", self, "_on_mouse_entered") == 0)
	assert(connect("mouse_exited", self, "_on_mouse_exited") == 0)
	assert(connect("area_entered", self, "_on_area_entered") == 0)
	assert($ColorTimer.connect("timeout", self, "_on_timeout") == 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
