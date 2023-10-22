extends Area2D

signal number_entered(number: Area2D, _name : String)

var place : int
var tenth_place_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/tenth_place_texture.svg")
var one_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/unit.png")
var ten_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/tens.png")
var hundred_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/hundreds.png")
var collision_shape := CollisionShape2D.new()
var sprite = Sprite2D.new()
var start_position = Vector2(400, 500)
var indicator : AnimatedSprite2D = preload("res://minigames/generics/puzzles/amounts/indicator.tscn").instantiate()

var textures : Dictionary = {
	-1: tenth_place_texture,
	1: one_place_texture,
	2: ten_place_texture,
	3: hundred_place_texture
}


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(area_entered.connect(_on_area_entered) == 0)
	add_child(indicator)
	indicator.scale = 0.5*Vector2(1,1)
	scale = Vector2(0.9,0.9)

func _init(_place: int):
	collision_shape.shape = RectangleShape2D.new()
	sprite.texture = textures[_place]
	collision_shape.shape.size = sprite.texture.get_size()
	
	if _place == 1:
		indicator.position = Vector2(0, -300)
	if _place == 2:
		indicator.position = Vector2(0, -300)
	if _place == 3:
		indicator.position = Vector2(0, -300)
			
	add_child(collision_shape)
	add_child(sprite)
	
	
func _on_area_entered(area : Area2D) -> void:
	emit_signal("number_entered", area, name)
