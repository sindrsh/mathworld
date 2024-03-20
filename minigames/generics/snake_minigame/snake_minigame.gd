extends MiniGame


var _fruit_scene = preload("res://components/fruit/fruit.tscn")
@onready var _fruit_container = get_node("Fruit")
@onready var _text: Label = get_node("Panel/Label")
var numbers = []

func _add_specifics():
	world_part = "counting"
	id = "snake_1_to_50" 
	minigame_type = AMOUNT
	
	spawn_fruit(10)
	
	_add_status_bar()
	
func _physics_process(_delta) -> void:
	if $Snake:
		status_bar.frame = $Snake.health


func spawn_fruit(amount: int):
	for i in range(amount):
		numbers.append(randi_range(1, 99))
	
	for n in numbers:
		# max x = 29
		# max y = 14
		var spawn_pos = Vector2(randi_range(1, 29), randi_range(1, 14)) * 64
		var fruit: NumberFruit = _fruit_scene.instantiate()
		
		_fruit_container.add_child(fruit)
		fruit.set_number(n)
		fruit.position = spawn_pos
		
		fruit.connect("eaten", _fruit_eaten)
		
		print("created fruit at " + str(spawn_pos))
	_text.text = str(numbers[len(numbers) - 1])


func _fruit_eaten(n: int):
	if n == numbers[len(numbers) - 1]:
		# did the correct thing
		numbers.pop_back()
	else:
		print(numbers)
		for i in range(len(numbers) - 1):
			print(i)
			# TODO: take damage
			if numbers[i] == n:
				numbers.pop_at(i)
	if len(numbers) > 0:
		_text.text = str(numbers[len(numbers) - 1])
