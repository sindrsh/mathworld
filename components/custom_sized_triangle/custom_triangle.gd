extends Node2D
class_name CustomTriangle


# index 0 = a, index 1 = b 
var bases = [50, 50]
@onready var polygon:Polygon2D = get_node("Polygon2D")


# actually updates the triangle's position
func update_triangle():
	print(bases)
	# the "a" side should be situated on the x axis with its midpoint at 0 on the x axis
	# the "b" side should be situated on the y axis with tis midpoint at 0 on the y axis
	# Therefore, the three ts of the triangle will be at:
	# (0.5 * a, -0.5 * b)
	# (-0.5 * a, -0.5 * b)
	# (0.5 * a, 0.5 * b)
	# this should keep the triangle centered
	
	# had to draw this out on paper to figure it out lol


	polygon.polygon = [
		Vector2(0.5 * bases[0], -0.5 * bases[1]),
		Vector2(-0.5 * bases[0], -0.5 * bases[1]),
		Vector2(0.5 * bases[0], 0.5 * bases[1]),
	]
	
	print(polygon.polygon)
	


# if the bases need to be changed that can just be done by manually setting the value
# in the array
# hypo = hypotaneuse or whatever I can't spell it
# will change the base not specified by fix
func change_hypo(c, fix="a"):
	var changing_base = 1
	var constant_base = 0
	if fix == "b":
		changing_base = 0
		constant_base = 1
	
	# pythagorean theorem in reverse
	# a = sqrt(c^2 - b^2)
	bases[changing_base] = sqrt((c * c) - (bases[constant_base] * bases[constant_base]))
