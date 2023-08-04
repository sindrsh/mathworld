extends Node2D

const MULTIPLIER = 7
@onready var triangle: CustomTriangle = get_node("custom_triangle")

# a
func _on_h_slider_value_changed(value):
	triangle.bases[0] = value * MULTIPLIER
	triangle.update_triangle()


# b
func _on_h_slider_2_value_changed(value):
	triangle.bases[1] = value * MULTIPLIER
	triangle.update_triangle()


# c
func _on_h_slider_3_value_changed(value):
	triangle.change_hypo(value * MULTIPLIER)
	triangle.update_triangle()
