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
	_line_start = $Endpoint1.position
	_line_length = $Endpoint1.position.distance_to($Endpoint2.position)
	_line_dir = $Endpoint1.position.angle_to_point($Endpoint2.position)


# Adds a new crack to the number line
func crack():
	_cracks.append(randi_range(0, _line_length))
	# Docs says that sort() behavior is unstable
	_cracks.sort_custom(func(a, b): return a < b)
	queue_redraw()


func _draw():
	var lines: Array[Array]
	var start: Vector2 = _line_start
	var end: Vector2
	print(_line_start)
	
	for crack in _cracks:
		end = get_line_position(crack - crack_length)
		lines.append([start, end])
		start = get_line_position(crack + crack_length)
	
	lines.append([start, _endpoints[1]])
	
	print(lines)
	
	for line in lines:
		draw_line(line[0], line[1], color, width)


func get_line_position(distance: int) -> Vector2:
	return _line_start + Vector2(distance, 0).rotated(_line_dir)
