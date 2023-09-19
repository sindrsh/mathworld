extends Node2D


var _fruit_scene = preload("res://components/fruit/fruit.tscn")
@onready var _fruit_container = get_node("Fruit")


func _ready():
	for i in range(1, 10):
		# max x = 29
		# max y = 14
		var spawn_pos = Vector2(randi_range(0, 29), randi_range(0, 14)) * 64
		var fruit: NumberFruit = _fruit_scene.instantiate()
		
		_fruit_container.add_child(fruit)
		fruit.set_number(i)
		fruit.position = spawn_pos
		
		print("created fruit at " + str(spawn_pos))
