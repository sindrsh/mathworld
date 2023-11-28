extends Node2D
class_name CrackingLine



var _cracks: Array[int] = []  # each "crack" is an integer that represents how far down the line the crack is
var _endpoints: Array[Vector2] = []

@export_color_no_alpha var color = Color(0, 0, 0)
@export var width: int = 2

@export var crack_length = 6
var _line_length: int
var _line_start: Vector2
var _line_dir: float

# [TODO) Add a shake whenever the line is cracked
# [TODO) Make the line create cracks 

func _ready():
	_endpoints.append($Endpoint1.position)
	_endpoints.append($Endpoint2.position)
	_line_length = $Endpoint1.position.distance_to($Endpoint2.position)
	_line_dir = $Endpoint1.position.angle_to($Endpoint2.position)  # does the cross product under the hood I think


# Adds a new crack to the number line
func crack():
	_cracks.append(randi_range(0, _line_length))
	queue_redraw()


func _draw():
	var points = [_endpoints[0]]
	for crack in _cracks:
		points.append(get_line_position(crack - crack_length))
		points.append(get_line_position(crack + crack_length))
	points.append(_endpoints[1])
	# it's mathematically impossible for points to have an odd number of elements so I'm not gonna assert it
	
	var lines: Array[Array]  # A 2D array of vector2's. Godot is stupid and doesn't allow you to explicitly define typed 2d arrays
	print(points)
	
	for i in range(0, len(points), 2):
		print("I'm in this for loop")
		lines.append([points[i], points[i+1]])
	
	print(lines)
	for line in lines:
		draw_line(line[0], line[1], color, width)


func get_line_position(distance: int) -> Vector2:
	return _line_start + Vector2(distance, 0).rotated(_line_dir)
