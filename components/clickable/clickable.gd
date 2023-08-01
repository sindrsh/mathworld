extends Area2D
# emits the signal on_click when clicked on
class_name Clickable

# TODO: implement support for press and release (cool UI effects?)

var hovering = false
signal on_click
signal on_hover_start
signal on_hover_stop




func _on_mouse_entered() -> void:
	hovering = true;
	emit_signal("on_hover_start")


func _on_mouse_exited() -> void:
	hovering = false
	emit_signal("on_hover_stop")


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed and hovering:
			emit_signal("on_click")	
		return;
	
	if event is InputEventScreenTouch:
		if event.pressed:
			emit_signal("on_click")

	# TODO: make this work when the screen is tapped as well
