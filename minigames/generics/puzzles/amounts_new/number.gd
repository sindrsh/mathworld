extends TextureButton

var speed := 20.0
var moving:= false
var target : Vector2:
	set(_target):
		target = _target
		moving = true
var place : int
var clicks : int

var one_texture = preload("res://minigames/generics/puzzles/amounts_new/assets/one.svg")
var ten_texture = preload("res://minigames/generics/puzzles/amounts_new/assets/ten.svg")
var hundred_texture = preload("res://minigames/generics/puzzles/amounts_new/assets/hundred.svg")
var ten_ones: Texture2D = preload("res://minigames/generics/puzzles/amounts_new/assets/ten_ones.svg")
var ten_tens: Texture2D = preload("res://minigames/generics/puzzles/amounts_new/assets/ten_tens.svg")
var hundred_ones : Texture2D = preload("res://minigames/generics/puzzles/amounts_new/assets/hundred_ones.svg")
var default_texture : Texture2D


func _ready() -> void:
	pressed.connect(_on_clicks)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		_move()


func _input(event):
	if event is InputEventMouseButton and not is_hovered():
		if clicks != 0:
			texture_normal = default_texture
			clicks = 0

func _move() -> void:
	if position.distance_to(target) > speed:
		position += speed*position.direction_to(target)
	else:
		position = target
		moving = true


func _on_clicks() -> void:
	clicks += 1
	if place == 2:
		if clicks == 1:
			texture_normal = ten_ones
		else:
			texture_normal = default_texture
			clicks = 0
			
	if place == 3:
		match clicks:
			1: 
				texture_normal = ten_tens
			2: 
				texture_normal = hundred_ones
			_: 
				texture_normal = default_texture
				clicks = 0
			
				
func set_texture() -> void:
	if place == 1:
		default_texture = one_texture
	if place == 2:
		default_texture = ten_texture
	if place == 3:
		default_texture = hundred_texture
	texture_normal = default_texture
	position = -texture_normal.get_size()/2.0
			
		
