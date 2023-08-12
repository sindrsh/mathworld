extends RigidBody2D

var following_mouse := false
var mouse_difference := Vector2(0, 0)

func _physics_process(delta) -> void:
	if following_mouse:
		position = mouse_difference + get_global_mouse_position()

func _integrate_forces(state):
	if following_mouse:
		linear_velocity = Vector2(0, 0)

func _on_clickable_on_press() -> void:
	linear_velocity = Vector2(0, 0)
	mouse_difference = position - get_global_mouse_position()
	following_mouse = true


func _on_clickable_on_release() -> void:
	following_mouse = false
