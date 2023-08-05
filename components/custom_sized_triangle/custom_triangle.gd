extends Node2D
class_name CustomTriangle


# index 0 = a, index 1 = b 
var bases = [50, 50]


# actually updates the triangle's position
func update_triangle():
	queue_redraw()



func _draw():
	# draws the main triangle
	# had to draw out on paper how to actually get this to work
	draw_polygon([
		Vector2(0.5 * bases[0], 0.5 * bases[1]),
		Vector2(-0.5 * bases[0], 0.5 * bases[1]),
		Vector2(0.5 * bases[0], -0.5 * bases[1])
	], [Color(0, 0, 0)])
	
	# draws the squares on the bases
	draw_rect(Rect2(
		Vector2(0.5 * bases[0], -0.5 * bases[1]),
		Vector2(bases[1], bases[1])
	), Color(1, 0, 0, 0.5))
	
	draw_rect(Rect2(
		Vector2(-0.5 * bases[0], 0.5 * bases[1]),
		Vector2(bases[0], bases[0])
	), Color(0, 1, 0, 0.5))
	
	# draws the squares on the hypo
	var c = sqrt((bases[0] * bases[0]) + (bases[1] * bases[1]))
