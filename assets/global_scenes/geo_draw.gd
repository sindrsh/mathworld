extends Node2D

var center : Vector2 = Vector2(0, 0)
var radius : float = 80
var width : float = 3
var points : int = 1000
var angle1 : float
var angle2 : float
var square_length : float
var rectangle_width : float
var rectangle_height : float
var fill = false
var color = Color(0,0,0)
var fill_color = Color(0,1,0,0.3)

enum {CIRCLE, SECTOR, SQUARE, RECTANGLE}
var shape : int

func _mk_circle():
	var circle_points : PackedVector2Array = []
	var dv : float = 2*PI/points
	for i in range(points + 1):
		circle_points.append(center + Vector2(cos(i*dv), -sin(i*dv))*radius)
	draw_polyline(circle_points, color, width, true)
	
func _mk_sector():
	var circle_points : PackedVector2Array = []
	var arc_points : int = int(abs(angle1-angle2)/(2*PI)*points)
	var dv = abs(angle1-angle2)/arc_points
	for i in range(arc_points+1):
		circle_points.append(center + Vector2(cos(i*dv), -sin(i*dv))*radius)
	
	draw_polyline(circle_points, color, width, true)
	draw_line(circle_points[0], center, color, width, true)	
	draw_line(circle_points[-1], center, color, width, true)						
	if fill:
		circle_points.append(center)
		draw_colored_polygon(circle_points, fill_color)	

func _draw():
	match shape:
		CIRCLE:
			_mk_circle()
		SECTOR:
			_mk_sector()
		_:
			pass
