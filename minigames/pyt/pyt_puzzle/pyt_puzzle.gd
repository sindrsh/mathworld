extends MiniGame

var a : float = 80
var b : float = 150 

func _add_specifics():
	
	var dx : float = 150.0
	var dy : float = 400.0
	
	$Framework.position = Vector2(500, 150)
	$Measures.position = $Framework.position + Vector2(900.0, 0)
	
	$Equation1.position = $Framework.position + Vector2(0.0, dy)
	$Equation2.position = $Equation1.position + Vector2(0.0, dy)	
	$Equation3.position = $Equation1.position + Vector2(1100.0, dy/2)		
	
	var horz_line : Line2D = Line2D.new()
	horz_line.points = PackedVector2Array([
		Vector2(80.0, 0.0), 
		Vector2(980.0, 0.0)
	])
	horz_line.default_color = Color(0,0,0, 0.5)
	horz_line.width = 5
	horz_line.position.y = $Framework.position.y + dy/2
	add_child(horz_line)
	
	var horz_line2 : Line2D = horz_line.duplicate()
	horz_line2.position.y = horz_line.position.y + dy
	add_child(horz_line2)
	
	var vertc_line : Line2D = Line2D.new()
	vertc_line.points = PackedVector2Array([
		Vector2(0.0, 0.0), 
		Vector2(0.0, 1000.0)
	])
	vertc_line.default_color = Color(0,0,0,0.5)
	vertc_line.width = 5.0
	vertc_line.position = Vector2(horz_line.points[1].x, 20)
	add_child(vertc_line)
	
	var horz_line3 : Line2D = horz_line.duplicate()
	horz_line3.position.x = horz_line.points[1].x - horz_line.points[0].x
	add_child(horz_line3)
	
	$RectTp.position = $Equation1.position + Vector2(-dx-a-b, -120)
	$RectBtm.position = $RectTp.position + Vector2(a, b)
	$SqrA.position = $RectTp.position + Vector2(0, b)
	$SqrB.position = $RectTp.position + Vector2(a, 0)
	
	$TriBtmRght.position = Vector2($Equation1.position.x + dx + b, $RectTp.position.y + a)
	$TriTpRght.position = $TriBtmRght.position + Vector2(-b+a, -a) 
	$TriTpLft.position = $TriBtmRght.position + Vector2(-b, -a) 
	$TriBtmLft.position = $TriBtmRght.position + Vector2(-b, b-a) 	
	$TriSquare.position = $TriBtmRght.position + Vector2(-b, -a) 
	
	var label_dx : float = 60.0
	
	var a2 : TextureButton = load("res://minigames/pyt/pyt_puzzle/movable_shape.tscn").instantiate()
	a2.texture_normal = load("res://minigames/pyt/pyt_puzzle/assets/a2.svg")
	add_child(a2)
	a2.position = $Equation3.position - Vector2(400, 200)
	
	var a22 : TextureButton = a2.duplicate()
	a22.position = a2.position + Vector2(label_dx, 0.0)
	add_child(a22)
	
	var b2 : TextureButton = load("res://minigames/pyt/pyt_puzzle/movable_shape.tscn").instantiate()
	b2.texture_normal = load("res://minigames/pyt/pyt_puzzle/assets/b2.svg")
	b2.position = a22.position + Vector2(label_dx, 0.0)
	add_child(b2)	
	
	var b22 : TextureButton = b2.duplicate()
	b22.position = b2.position + Vector2(label_dx, 0.0)
	add_child(b22)
	
	var c2 : TextureButton = load("res://minigames/pyt/pyt_puzzle/movable_shape.tscn").instantiate()
	c2.texture_normal = load("res://minigames/pyt/pyt_puzzle/assets/c2.svg")
	c2.position = b22.position + Vector2(label_dx, 0.0)	
	add_child(c2)		

	var c22 : TextureButton = c2.duplicate()
	c22.position = c2.position + Vector2(label_dx, 0.0)
	add_child(c22)

	var plus : TextureButton = load("res://minigames/pyt/pyt_puzzle/movable_shape.tscn").instantiate()
	plus.texture_normal = load("res://minigames/pyt/pyt_puzzle/assets/plus.svg")
	plus.position = c22.position + Vector2(label_dx, 0.0)
	add_child(plus)		
	
