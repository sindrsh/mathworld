extends Node2D
signal make_new_alternatives(_value: int)

var tick_scene : PackedScene = preload("res://minigames/generics/run_hill/tick.tscn")
var speed := 200.0
var amplitude := 180.0
var graph := Line2D.new()
var periods := 10
var obstacles = []
var current_obstacle : Area2D
var ticks := []
var moving_objects = Node2D.new()
var moving := false


# Called when the node enters the scene tree for the first time.
func _ready():
	var n := 200
	var dx := 2*PI/n
	
	graph.position = Vector2(100, 500)
	$Path2D.position = graph.position
	graph.default_color = Color(0, 0, 1)
	
	for i in range(periods*n):
		var point := amplitude*Vector2(dx*i, -_path_func(dx*i))
		graph.add_point(point)
		$Path2D.curve.add_point(point + Vector2(0, -32))
		
	add_child(graph)
	_add_ticks()


func _physics_process(delta):
	if moving:
		# this took about an hour of math to figure out
		# my calc teacher would be proud
		var path_pos = $Path2D/PathFollow2D.get_progress()
		$Path2D/PathFollow2D.set_progress(path_pos + speed * delta)
		$Path2D/PathFollow2D/Sprite2D.rotation += PI * delta
	else:
		$Path2D/PathFollow2D.set_progress($Path2D/PathFollow2D.get_progress())
	
	
func _path_func(x: float) -> float:
	return cos(x)

# I assume this means the derivative of the path function?
# I thought the derivative of cos(x) was -sin(x)?
#      - firesquid
func _path_func_der(x: float) -> float:
	return sin(x)

func _add_ticks() -> void:
	var n := 2000
	var dx := 2*PI/n
	var graph_points = PackedVector2Array()
	var distance := 0.0
	var distances := [0.0]
	graph_points.append(amplitude*Vector2(0,-1))
	
	for i in range(1, periods*n+1):
		graph_points.append(amplitude*Vector2(dx*i, -_path_func(dx*i)))
		distance += graph_points[i-1].distance_to(graph_points[i])
		distances.append(distance)
	
	var ds = distance/(periods*10.0)
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
			if i % 5 == 0:
				slope_angle = 0
			tick.value = i
			tick.rotate(slope_angle)
			tick.position = graph.position + graph_points[j]
			var text: Text = tick.get_node("Text")
			text.font_size = 40
			text.set_new_text(str(i))
			text.center_text()
			text.position += Vector2(0, 30)
			if (i % 5) != 0:
				text.hide()
			i += 1
			add_child(tick)
			ticks.append(tick)
	
	var ints := [1, 2, 3, 4, 6, 7, 8, 9]
	randomize()
	
	for j in range(ticks.size() - 10):
		if j % 10 == 0:
			var tick_index : int = j + ints[randi() % 8]
			ticks[tick_index].get_node("ObstacleAnimation").show()
			ticks[tick_index].tick_is_obstacle = true
			obstacles.append(ticks[tick_index])
	
	current_obstacle = obstacles[0]
	current_obstacle.get_node("ObstacleAnimation").play()
	
	for k in range(obstacles.size() - 1):
		obstacles[k].next_obstacle = obstacles[k+1]
		
				
func _mk_task():
	pass


func _on_tick_hit(_name : String) -> void:
	var tck = get_node(_name)
	tck.get_node("Text").show()
	if tck.tick_is_obstacle:
		emit_signal("make_new_alternatives", (tck.value/10)*10)


func _on_area_2d_area_entered(area):
	var tick = area as Tick
