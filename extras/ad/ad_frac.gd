extends Node2D

var neg_num_scene : PackedScene = preload("res://assets/global_scenes/geo_shape.tscn")
var x_scale = 500
var pos_col = Color(0,0,1)
var dy = 40
var number_line : NumberLine

var max : int = 10
var k : int = 2
var denominator : int = 6
var dx : float = 1.0/denominator
	
# Called when the node enters the scene tree for the first time.
func _mk_num_line() -> void:
	number_line = NumberLine.new()
	number_line.mk_x_axis(0, max*dx, x_scale)
	number_line.position = Vector2(400, 700)
	
	number_line.mk_x_tick(Vector2(0, 0), "0")
	number_line.mk_x_tick(Vector2(x_scale, 0),"1")
	for i in range(max+1):
		if i == k:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0), "", 1, Color(1,0,0))
		else:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0))			
	add_child(number_line)	

func _mk_num_line_wth_frac_tick() -> void:
	number_line = NumberLine.new()
	number_line.mk_x_axis(0, max*dx, x_scale)
	number_line.position = Vector2(400, 700)
	
	number_line.mk_x_tick(Vector2(0, 0), "0")
	number_line.mk_x_tick(Vector2(x_scale, 0),"1", -5)
	for i in range(max+1):
		if i == k:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0), "", 1, Color(1,0,0))
		else:
			number_line.mk_x_tick(Vector2(i*dx*x_scale, 0))	
		var tick_frac : FracLabel = FracLabel.new(str(i), str(denominator), 30)		
		if i > 0:
			tick_frac.position = number_line.position + Vector2(i*dx*x_scale, 60)
			add_child(tick_frac)	
	add_child(number_line)	

func _ready():
	_mk_num_line_wth_frac_tick()
#	var tick_frac : FracLabel = FracLabel.new(str(k), str(denominator), 30)		
#	tick_frac.position = number_line.position + Vector2(k*dx*x_scale, 60)
#	add_child(tick_frac)
	
	

	

	
