extends MiniGame

var tick_scene : PackedScene = preload("res://minigames/generics/run_hill/tick.tscn")
var speed := 100.0
var amplitude := 100.0
var graph := Line2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var n := 200
	var dx := 2*PI/n
	
	graph.position = Vector2(100, 500)
	$Path2D.position = graph.position
	graph.default_color = Color(0, 0, 1)
	
	for i in range(n):
		var point := amplitude*Vector2(dx*i, -_path_func(dx*i))
		graph.add_point(point)
		$Path2D.curve.add_point(point + Vector2(0, -32))
		
	add_child(graph)
	_add_ticks()


func _physics_process(delta):
	$Path2D/PathFollow2D.set_progress($Path2D/PathFollow2D.get_progress() + speed * delta)


func _path_func(x: float) -> float:
	return cos(x)

func _path_func_der(x: float) -> float:
	return sin(x)

func _add_ticks() -> void:
	var n := 2000
	var dx := 2*PI/n
	var graph_points = PackedVector2Array()
	var distance := 0.0
	var distances := [0.0]
	graph_points.append(amplitude*Vector2(0,-1))
	
	for i in range(1, n+1):
		graph_points.append(amplitude*Vector2(dx*i, -_path_func(dx*i)))
		distance += graph_points[i-1].distance_to(graph_points[i])
		distances.append(distance)
	
	var ds = distance/10.0
	var i := 0
	
	for j in range(distances.size()):
		if distances[j] >= i*ds:
			var tick : Area2D = tick_scene.instantiate()
			assert(tick.hit.connect(_on_tick_hit) == 0)
			var slope_angle := Vector2(1, _path_func_der(graph_points[j].x)).angle()
			if (i % 10) < 5:
				slope_angle = abs(slope_angle)
			else: 
				slope_angle = -abs(slope_angle)
			tick.rotate(slope_angle)
			tick.position = graph.position + graph_points[j]
			var text: Text = tick.get_node("Text")
			text.font_size = 40
			text.set_new_text(str(i))
			text.center_text()
			text.position += Vector2(0, 30)
			if (i % 10) != 5:
				text.hide()
			if i == 0:
				text.show()
			i += 1
			add_child(tick)

func _on_tick_hit(_name : String) -> void:
	get_node(_name).get_node("Text").show()
		
			
