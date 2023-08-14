extends Area2D

signal number_entered(number: Area2D, _name : String)

var place : int
var tenth_place_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/tenth_place_texture.svg")
var one_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/one_place_texture.svg")
var ten_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/ten_place_texture.svg")
var hundred_place_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/hundred_place_texture.svg")
var collision_shape := CollisionShape2D.new()
var sprite = Sprite2D.new()
var start_position = Vector2(400, 500)

var textures : Dictionary = {
	-1: tenth_place_texture,
	1: one_place_texture,
	2: ten_place_texture,
	3: hundred_place_texture
}


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(area_entered.connect(_on_area_entered) == 0)

func _init(_place: int):
	collision_shape.shape = RectangleShape2D.new()
	sprite.texture = textures[_place]
	collision_shape.shape.size = sprite.texture.get_size()
	
	add_child(collision_shape)
	add_child(sprite)	
	
	
func _on_area_entered(area : Area2D) -> void:
	print("area entered")
	emit_signal("number_entered", area, name)
