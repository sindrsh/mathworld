extends RigidBody2D

var following_mouse := false
var mouse_difference := Vector2(0, 0)

func _physics_process(delta) -> void:
	if following_mouse:
		position = mouse_difference + get_global_mouse_position()
	
	# ensures that the balls don't stick around forever
	if abs(position.x) > 100000 or abs(position.y) > 10000:
		queue_free()

func _integrate_forces(state):
	if following_mouse:
		linear_velocity = Vector2(0, 0)

func _on_clickable_on_press() -> void:
	linear_velocity = Vector2(0, 0)
	mouse_difference = position - get_global_mouse_position()
	following_mouse = true


func _on_clickable_on_release() -> void:
	following_mouse = false
