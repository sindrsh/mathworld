extends Node2D
class_name GeoShape

var shape : Object
var characteristics

func _get_pair(v):
	return Vector2(cos(v), sin(v))

func mk_vec(length : float, angle : float, len_scale : float, vec_color : Color = Color(0,0,0), width : float = 5.0):
	characteristics = [length, angle]
	var line : Line2D = Line2D.new()
	line.width = width
	line.default_color = vec_color
	add_child(line)
	
	var tri_scale : float = 12.0
	var triD : Vector2 = length*len_scale*Vector2(1, 0) - tri_scale*Vector2(sqrt(3)/2, 0)
	var triA : Vector2 = triD + tri_scale*Vector2(sqrt(3)/2, 0)
	var triB : Vector2 = triD + -tri_scale*Vector2(0, 1)
	var triC : Vector2 = triD + tri_scale*Vector2(0, 1)
	
	var triangle : Polygon2D = Polygon2D.new()
	triangle.polygon = PackedVector2Array([
		triA,
		triB,
		triC,
	])
	triangle.color = vec_color
	triangle.polygon = triangle.polygon*Transform2D(angle, Vector2(0,0))
	line.points = PackedVector2Array([
		Vector2(0,0),
		length*len_scale*Vector2(1, 0) - tri_scale*Vector2(sqrt(3)/2, 0)
	])
	line.points = line.points*Transform2D(angle, Vector2(0,0))
	
	add_child(triangle)
	
	var length_label : Text = Text.new(40, str(length))
	length_label.position = (triangle.polygon[0]-line.points[0])/2 - Vector2(length_label.string_size.x/2, 50)
	add_child(length_label)
	
func mk_triangle(a : float, b : float, c : float, s : float = 1.0) -> void:
	assert(a+b-c > 0)
	assert(a-b+c > 0)
	assert(-a+b+c > 0)
	var triangle : Polygon2D = Polygon2D.new()
	triangle.polygon = PackedVector2Array([
		s*Vector2(0,0),
		s*Vector2(c, 0),
		s*Vector2((c**2-a**2+b**2)/(2*c), sqrt(b**2-((c**2-a**2+b**2)/(2*c))**2))
	])
	triangle.color = Color(0,0,0)
	add_child(triangle)



