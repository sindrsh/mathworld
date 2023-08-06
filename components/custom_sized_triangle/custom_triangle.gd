extends Node2D
class_name CustomTriangle


# index 0 = a, index 1 = b 
var bases = [50, 50]


# actually updates the triangle's position
func update_triangle():
	queue_redraw()



func _draw():
	var bottom_left = Vector2(-0.5 * bases[0], 0.5 * bases[1])
	var top_right = Vector2(0.5 * bases[0], -0.5 * bases[1])
	var bottom_right = Vector2(0.5 * bases[0], 0.5 * bases[1])
	
	# draws the main triangle
	# had to draw out on paper how to actually get this to work
	draw_polygon([
		bottom_right,
		top_right,
		bottom_left
	], [Color(0, 0, 0)])
	
	# draws the squares on the bases
	draw_rect(Rect2(
		top_right,
		Vector2(bases[1], bases[1])
	), Color(1, 0, 0, 0.5))
	
	draw_rect(Rect2(
		bottom_left,
		Vector2(bases[0], bases[0])
	), Color(0, 1, 0, 0.5))
	
	# draws the squares on the hypo
	var c = sqrt((bases[0] * bases[0]) + (bases[1] * bases[1]))
	var angle = 2 * PI - ((PI / 2) + atan(bases[1] / bases[0]))
	var side = Vector2(c, 0).rotated(angle)
	
	print("drawing hypotaneuse")
	print(side)
	print(side + top_right)
	print(side + bottom_left)
	print(top_right)
	print(bottom_left)
	draw_polygon([
		top_right,
		bottom_left,
		side + bottom_left,
		side + top_right,
		 
	], [Color(0, 0, 1, 0.5)])
	
