extends HBoxContainer
class_name HeartBar

# todo: make this use half hearts?
@export var max_health: int = 5
@export var initial_value: int = 4

var _value: int = 0
var _texture_rects: Array[TextureRect] = []

var empty_texture = preload("res://assets/Heart Empty.svg") 
var full_texture = preload("res://assets/Heart Full.svg")

func _ready():
	for i in range(max_health):
		var texture_rect = TextureRect.new()
		_texture_rects.append(texture_rect)
		add_child(texture_rect)
	set_value(initial_value)


func set_value(value: int):
	_value = value
	
	# godot should really support enumerating this is ridiculous
	for i in range(len(_texture_rects)):
		var texture_rect = _texture_rects[i]
		if i >= value:
			texture_rect.texture = full_texture
		else:
			texture_rect.texture = empty_texture


func get_value():
	return _value


func _decrease_value():
	set_value(_value - 1)
