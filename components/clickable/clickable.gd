extends Area2D
# emits the signal on_click when clicked on
class_name Clickable

# TODO: implement support for press and release (cool UI effects?)

var hovering = false
signal on_click
signal on_hover_start
signal on_hover_stop
signal on_press
signal on_release


func _on_mouse_entered() -> void:
	hovering = true;
	emit_signal("on_hover_start")


func _on_mouse_exited() -> void:
	hovering = false
	emit_signal("on_hover_stop")


func _input(event) -> void:
	# kinda a mess of if statements but i don't think there's any other way
	if event is InputEventMouseButton and hovering:
		if event.pressed:
			emit_signal("on_click")
		if event.is_released():
			emit_signal("on_release")
		if event.is_pressed():
			emit_signal("on_press")
		return;

	# TODO: make this work when the screen is tapped as well
