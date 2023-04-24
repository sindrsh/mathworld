extends MiniGame

const Number = preload("res://minigames/counting/number_catch_0_to_9/number.gd")
var number : Number = preload("res://minigames/counting/number_catch_0_to_9/Number.tscn").instantiate()
#var circle_white : Texture2D = preload("res://minigames/generics/assets/circle_white.svg")
#var circle_blue : Texture2D = preload("res://minigames/generics/assets/circle_purple.svg")
var tennis_ball : Texture2D = preload("res://minigames/generics/assets/tennis_ball_small.png")
var tennis_ball_purple : Texture2D = preload("res://minigames/generics/assets/tennis_ball_small_purple.png")
var character : Node2D = preload("res://minigames/counting/number_catch_0_to_9/Character.tscn").instantiate()
const radius := 50.0
const left_margin := 100
const right_margin := 360
const top_margin := -100
var width : float
var current_sprite : Sprite2D
var current_node : Node2D
var collision_area : Area2D

var values : Array = [
	preload("res://minigames/generics/assets/stroke_numbers/one-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/two-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/three-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/four-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/five-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/six-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/seven-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/eight-stroke.svg"),
	preload("res://minigames/generics/assets/stroke_numbers/nine-stroke.svg"),		
]

# Called when the node enters the scene tree for the first time.
func _add_specifics() -> void:
	var area2D : Area2D = character.get_node("number_container/Area2D")
	assert(area2D.connect("body_entered", _on_character_entered) == 0)
	assert($Timer.connect("timeout", _spawn_numbers) == 0)
	
	width = get_viewport_rect().size.x-right_margin
	number.get_node("Circle").texture = tennis_ball
	var OneSprite := Sprite2D.new() 
	OneSprite.texture = values[0]
	current_node = character.get_node("number_container")
	current_node.add_child(OneSprite)
	current_sprite = current_node.get_node("Circle")
	current_sprite.texture = tennis_ball_purple
	collision_area = current_node.get_node("Area2D")
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
		num.position = Vector2(left_margin+randf_range(i*width/3, (i+1)*width/3), top_margin)
		add_child(num)


func update_physics(NumberContainer):
	current_node.rotation = 0
	current_node.remove_child(collision_area)
	NumberContainer.add_child(collision_area)
	current_node.add_child(NumberContainer)
	current_node = NumberContainer


func stop_move():
	character.down_speed = 0


func _on_character_entered(body : Node2D) -> void:
	if body as Number and body.value == character.value + 1:
		var NumberContainer := Node2D.new()
		var NumberSprite := Sprite2D.new() 
		var CircleSprite := Sprite2D.new()
		NumberContainer.name = 'number_container'
		NumberSprite.texture = values[body.value - 1]
		NumberContainer.position = Vector2(0, -2*radius)
		CircleSprite.position = NumberSprite.position
		CircleSprite.texture = tennis_ball_purple
		character.value += 1
		call_deferred('update_physics', NumberContainer)
		character.down_speed = 1
		var timer = get_tree().create_timer(0.25)
		assert(timer.connect("timeout", stop_move) == 0)
		NumberContainer.add_child(CircleSprite)
		NumberContainer.add_child(NumberSprite)
		current_sprite.texture = tennis_ball
		current_sprite = CircleSprite
		body.queue_free()
		
		if character.value == 9:
			await get_tree().create_timer(0.5).timeout
			get_tree().reload_current_scene()
