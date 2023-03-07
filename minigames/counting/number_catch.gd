extends Node2D

const Number = preload("res://minigames/counting/number.gd")
var number : Number = preload("res://minigames/counting/Number.tscn").instantiate()
var circle : Texture2D = preload("res://minigames/generics/assets/circle_white.svg")
var character : Area2D = preload("res://minigames/counting/Character.tscn").instantiate()
var radius := 50.0

var values : Array = [
	preload("res://minigames/generics/assets/one.svg"),
	preload("res://minigames/generics/assets/two.svg"),
	preload("res://minigames/generics/assets/three.svg"),
	preload("res://minigames/generics/assets/four.svg"),
	preload("res://minigames/generics/assets/five.svg"),
	preload("res://minigames/generics/assets/six.svg"),
	preload("res://minigames/generics/assets/seven.svg"),
	preload("res://minigames/generics/assets/eight.svg"),
	preload("res://minigames/generics/assets/eight.svg"),		
]

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(character.connect("body_entered", _on_character_entered) == 0)
	assert($Timer.connect("timeout", _spawn_number) == 0)
	number.get_node("Circle").texture = circle	
	var OneSprite := Sprite2D.new() 
	OneSprite.texture = values[0]
	character.add_child(OneSprite)
	add_child(character)
	
func _process(delta):
	pass

func _spawn_number():
	randomize()
	var random_number = randi() % 9
	var num : Number = number.duplicate()
	num.value = random_number + 1
	num.get_node("Value").texture = values[random_number]
	num.position = Vector2(randf_range(0, get_viewport_rect().size.x-100), 100)
	add_child(num)
	
func _on_character_entered(body : Node2D) -> void:
	
	if body as Number:
		if body.value == character.value + 1:
			var NumberSprite := Sprite2D.new() 
			var CircleSprite := Sprite2D.new()
			CircleSprite.texture = circle
			NumberSprite.texture = values[body.value - 1]
			character.add_child(CircleSprite)
			character.add_child(NumberSprite)
			NumberSprite.position = Vector2(0, -2*character.value*radius)
			CircleSprite.position = NumberSprite.position
			character.value += character.value
