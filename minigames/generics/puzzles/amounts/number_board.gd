extends Node2D

var value : int
var sprite := Sprite2D.new()
var number_label := Text.new(60, "0")
var one_board_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/number_board.svg")


func _ready():
	sprite.texture = one_board_texture
	number_label.center_text()
	add_child(sprite)
	add_child(number_label)
	
func one_up() -> void:
	value += 1
	number_label.set_new_text(str(value))
	number_label.center_text()
