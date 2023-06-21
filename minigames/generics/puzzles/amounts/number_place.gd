extends Area2D

signal number_entered(number: Area2D, _name : String)

var place : int
var txture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/number_place_sprite.svg")


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(area_entered.connect(_on_area_entered) == 0)
	$CollisionShape2D.shape.size = txture.get_size()
	$Sprite2D.texture = txture
	
func _on_area_entered(area : Area2D) -> void:
	emit_signal("number_entered", area, name)
