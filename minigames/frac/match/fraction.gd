extends Node2D

var sector_scene = preload("res://assets/global_scenes/GeoDraw.tscn")

func _init(numerator : int, denominator : int, radius : float) -> void:
	var dv : float = 2*PI/denominator
	
	var d_array = []
	var dv_array = []
	for i in range(denominator):
		d_array.append(i)
		dv_array.append(i*dv)
	randomize()
	d_array.shuffle()
	
	var sector : Node2D
	
	for _n in range(numerator):
		var k : int = d_array.pop_back()
		sector = sector_scene.instantiate()
		sector.radius = radius
		sector.shape = sector.SECTOR
		sector.angle2 = dv
		sector.rotate(k*dv)
		sector.fill = true
		sector.fill_color = Color(0,1,0,0.4)
		add_child(sector)
		
	for k in d_array:
		sector = sector_scene.instantiate()
		sector.radius = radius
		sector.shape = sector.SECTOR
		sector.angle2 = dv
		sector.rotate(k*dv)
		add_child(sector)
