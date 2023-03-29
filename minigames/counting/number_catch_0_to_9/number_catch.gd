extends MiniGame

const Number = preload("res://minigames/counting/number_catch_0_to_9/number.gd")
var number : Number = preload("res://minigames/counting/number_catch_0_to_9/Number.tscn").instantiate()
var circle_white : Texture2D = preload("res://minigames/generics/assets/circle_white.svg")
var circle_blue : Texture2D = preload("res://minigames/generics/assets/circle_blue.svg")
var character : Area2D = preload("res://minigames/counting/number_catch_0_to_9/Character.tscn").instantiate()
var radius := 50.0
var width : float
var current_sprite : Sprite2D

var values : Array = [
	preload("res://minigames/generics/assets/one.svg"),
	preload("res://minigames/generics/assets/two.svg"),
	preload("res://minigames/generics/assets/three.svg"),
	preload("res://minigames/generics/assets/four.svg"),
	preload("res://minigames/generics/assets/five.svg"),
	preload("res://minigames/generics/assets/six.svg"),
	preload("res://minigames/generics/assets/seven.svg"),
	preload("res://minigames/generics/assets/eight.svg"),
	preload("res://minigames/generics/assets/nine.svg"),		
]

# Called when the node enters the scene tree for the first time.
func _add_specifics() -> void:
	assert(character.connect("body_entered", _on_character_entered) == 0)
	assert($Timer.connect("timeout", _spawn_numbers) == 0)
	
	width = get_viewport_rect().size.x-360
	
	number.get_node("Circle").texture = circle_white
	var OneSprite := Sprite2D.new() 
	OneSprite.texture = values[0]
	character.add_child(OneSprite)
	current_sprite = character.get_node("Circle")
	add_child(character)
	_spawn_numbers()
	$Timer.start()
	

func _spawn_numbers():
	randomize()
	
	for i in range(3):
		var random_number = randi() % 9
		var num : Number = number.duplicate()
		num.value = random_number + 1
		num.get_node("Value").texture = values[random_number]
		num.position = Vector2(100+randf_range(i*width/3, (i+1)*width/3), 100)
		add_child(num)


func _on_character_entered(body : Node2D) -> void:
	
	if body as Number:
		if body.value == character.value + 1:
			var NumberSprite := Sprite2D.new() 
			var CircleSprite := Sprite2D.new()
			NumberSprite.texture = values[body.value - 1]
			NumberSprite.position = Vector2(0, -2*character.value*radius)
			CircleSprite.position = NumberSprite.position
			CircleSprite.texture = circle_blue
			character.value += 1
			character.get_node("CollisionShape2D").position.y -= 2 * radius
			character.add_child(CircleSprite)
			character.add_child(NumberSprite)
			current_sprite.texture = circle_white
			current_sprite = CircleSprite
			body.queue_free()
			if character.value == 9:
				get_tree().reload_current_scene()
