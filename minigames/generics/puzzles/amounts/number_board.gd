extends Sprite2D

var sprite := Sprite2D.new()
var one_board_texture : Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/1boardwth0.svg")
var ten_board_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/10boardwth0.svg")
var hundred_board_texture: Texture2D = preload("res://minigames/generics/puzzles/amounts/assets/100boardwth0.svg")

var digit_width: int = one_board_texture.get_width()
var digit_sep: int = ten_board_texture.get_width() - 2*digit_width 

var ones : int
var tens: int
var hundreds: int

var one_card := Sprite2D.new()
var ten_card := Sprite2D.new()
var hundred_card := Sprite2D.new()

var one_cards : Array[Texture2D] = [
	null,
	preload("res://minigames/generics/puzzles/amounts/assets/1a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/2a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/3a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/4a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/5a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/6a.svg"),	
	preload("res://minigames/generics/puzzles/amounts/assets/7a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/8a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/9a.svg"),
]

var ten_cards : Array[Texture2D] = [
	null,
	preload("res://minigames/generics/puzzles/amounts/assets/10a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/20a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/30a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/40a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/50a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/60a.svg"),	
	preload("res://minigames/generics/puzzles/amounts/assets/70a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/80a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/90a.svg"),
]

var hundred_cards : Array[Texture2D] = [
	null,
	preload("res://minigames/generics/puzzles/amounts/assets/100a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/200a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/300a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/400a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/500a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/600a.svg"),	
	preload("res://minigames/generics/puzzles/amounts/assets/700a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/800a.svg"),
	preload("res://minigames/generics/puzzles/amounts/assets/900a.svg"),
]

func _ready():
	add_child(hundred_card)
	add_child(ten_card)
	add_child(one_card)
	
	
	
func one_up(place: int) -> void:
	if place == 1:
		ones += 1
		one_card.texture = one_cards[ones]
	if place == 2:
		tens += 1
		ten_card.texture = ten_cards[tens]
	if place == 3:
		hundreds += 1
		hundred_card.texture = hundred_cards[hundreds]		


func one_down(place: int) -> void:
	if place == 1:
		ones -= 1
		one_card.texture = one_cards[ones]
	if place == 2:
		tens -= 1
		ten_card.texture = ten_cards[tens]
	if place == 3:
		hundreds -= 1


func choose_board_digits(digits: int):
	if digits == 1:
		texture = one_board_texture
	if digits == 2:
		texture = ten_board_texture	
		one_card.position.x = (digit_width + digit_sep)/2.0
	if digits == 3:
		texture = hundred_board_texture	
		ten_card.position.x = (digit_width + digit_sep)/2.0
		one_card.position.x = digit_width + digit_sep
	
