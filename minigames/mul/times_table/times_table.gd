extends "res://minigames/generics/falling_bubbles/falling_bubbles.gd"

@export var number : int
var ints = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var small_times_table : Dictionary = { 0: [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [0, 10]], 1: [[1, 1]], 2: [[1, 2]], 3: [[1, 3]], 4: [[1, 4], [2, 2]], 5: [[1, 5]], 6: [[1, 6], [2, 3]], 7: [[1, 7]], 8: [[1, 8], [2, 4]], 9: [[1, 9], [3, 3]], 10: [[1, 10], [2, 5]], 12: [[2, 6], [3, 4]], 14: [[2, 7]], 16: [[2, 8], [4, 4]], 18: [[2, 9], [3, 6]], 20: [[2, 10], [4, 5]], 15: [[3, 5]], 21: [[3, 7]], 24: [[3, 8], [4, 6]], 27: [[3, 9]], 30: [[3, 10], [5, 6]], 28: [[4, 7]], 32: [[4, 8]], 36: [[4, 9], [6, 6]], 40: [[4, 10], [5, 8]], 25: [[5, 5]], 35: [[5, 7]], 45: [[5, 9]], 50: [[5, 10]], 42: [[6, 7]], 48: [[6, 8]], 54: [[6, 9]], 60: [[6, 10]], 49: [[7, 7]], 56: [[7, 8]], 63: [[7, 9]], 70: [[7, 10]], 64: [[8, 8]], 72: [[8, 9]], 80: [[8, 10]], 81: [[9, 9]], 90: [[9, 10]], 100: [[10, 10]] }

func _add_specifics():
	_make_task()

func _make_task() -> void:
	chosen_bubble = ''
	if bubble:
		bubble.queue_free()
	for _bullet in bullet_container.get_children():
		bullet_container.remove_child(_bullet)
		_bullet.queue_free() 
		
	randomize()
	var a = number
	ints.shuffle()
	var b : int = ints.pop_back()
	
	if randi() % 2 == 0:
		_add_bubble([a, b])
	else:
		_add_bubble([b, a])
	
	var x_values = [-1, 1, -3, 3]
	x_values.shuffle()
	
	_add_bullet(a*b, x_values.pop_back())
	
	var products = small_times_table.keys()
	products.shuffle()
	products.erase(a*b)

	for i in range(3):
		var product : int = products.pop_back()
		_add_bullet(product, x_values[i])
		

func _add_bubble(values : Array) -> void:
	bubble = Bubble.new()
	assert(bubble.connect("bubble_pressed", _on_bubble_pressed) == 0)
	var bubble_string := Text.new(30, str(values[0]) +  " \u00B7 " + str(values[1]))
	bubble_string.center_text()
	bubble.int_value = values
	add_child(bubble)
	bubble.add_child(bubble_string)
	bubble.position = Vector2(window.x/2, 0)


func _add_bullet(value : int, x_adjust : int) -> void:
	var bullet := Bullet.new()
	assert(bullet.connect("bullet_pressed", _on_bullet_pressed) == 0)
	assert(bullet.connect("target_reached", _on_target_reached) == 0)	
	bullet.int_value = [value]
	bullet.position = Vector2(x_adjust*200 + window.x/2, window.y - 150)	
	bullet_container.add_child(bullet)

	var bullet_string = Text.new(40, str(value))
	bullet_string.center_text()
	bullet.add_child(bullet_string)


func _correct_bullet(_name : String) -> bool:
	var mult : Array = get_node(_name).int_value
	return bullet_container.get_node(chosen_bubble).int_value[0] == mult[0]*mult[1]


func _accomplished() -> bool:
	return ints.is_empty()


"""
var small_times_table : Dictionary
var products : PackedInt32Array
number = 2
while not ints.is_empty():
	var a = ints.pop_front()
	if a*a in products:
		small_times_table[a*a].append([a, a])
	else:
		small_times_table[a*a] = [[a, a]]
		products.append(a*a)
			
	for b in ints:
		if a*b in products:
			small_times_table[a*b].append([a, b])
		else:
			small_times_table[a*b] = [[a, b]]
			products.append(a*b)
print(small_times_table)
"""
