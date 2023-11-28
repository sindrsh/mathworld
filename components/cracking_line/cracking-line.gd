extends Node2D
class_name CrackingLine


var _cracks: Array[Vector2] = []

@onready var endpoints: Array[Vector2] = []
@export_color_no_alpha var color = Color(0, 0, 0)
@export var width: int = 2



func _ready():
	endpoints.append($Endpoint1.position)
	endpoints.append($Endpoint2.position)


# Adds a new crack to the number line
func crack():
	print("crack")
	queue_redraw()


func _draw():
	print("Draw func just ran")
	draw_line(endpoints[0], endpoints[1], color, width)

