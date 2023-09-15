extends MiniGame


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var n := 100
	var dx := 2*PI/n
	var graph_container := Node2D.new()
	
	for i in range(1, n+1):
		var road_block := StaticBody2D.new()
		var road_block_collision := CollisionShape2D.new()
		var road_block_shape := SegmentShape2D.new()
		var a := 100*Vector2(dx*(i-1), -cos(dx*(i-1)))
		var b := 100*Vector2(dx*i, -cos(dx*i))	
		road_block_collision.shape = road_block_shape
		
		road_block_shape.a = a
		road_block_shape.b = b
		
		var segment := Line2D.new()
		segment.default_color = Color(0, 0, 1)
		segment.points = PackedVector2Array(
			[
			a,
			b	
			]
		)
		
		graph_container.add_child(segment)
		road_block.add_child(road_block_collision)
		graph_container.add_child(road_block)
	graph_container.position = Vector2(100, 200)
	add_child(graph_container)
	


