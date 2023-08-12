extends Area2D
# emits the signal on_click when clicked on
class_name Clickable

# TODO: implement support for press and release (cool UI effects?)

var hovering = false
var mouse_difference := Vector2(0, 0)
var dragging = false
@export var draggable = false
signal on_click
signal on_hover_start
signal on_hover_stop
signal on_press
signal on_release


func _ready():
	connect("on_press", _drag_start)
	connect("on_release", _drag_end)


func _process(delta):
	if dragging:
		position = get_global_mouse_position() + mouse_difference

func _on_mouse_entered() -> void:
	if dragging: return
	
	hovering = true;
	emit_signal("on_hover_start")


func _on_mouse_exited() -> void:
	if dragging: return
	
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



func _drag_start() -> void:
	if !draggable: return
	
	dragging = true
	mouse_difference = position - get_global_mouse_position()
	print("drag start")

func _drag_end() -> void:
	if !draggable: return
	
	dragging = false
	print("drag end")
