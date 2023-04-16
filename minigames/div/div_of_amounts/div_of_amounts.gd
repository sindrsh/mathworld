extends MiniGame

const Number = preload("res://minigames/div/div_of_amounts/number.gd")
var group : Area2D = preload("res://minigames/div/div_of_amounts/group.tscn").instantiate()
var one_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/one.svg")
var ten_texture : Texture2D = preload("res://minigames/div/div_of_amounts/assets/ten.svg")
var divisor : int = 5
var quotient : int 
var remainder : int
var group_container := HBoxContainer.new()
var window : Vector2
var dx := 20.0
var start_position : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	window = get_viewport_rect().size
	start_position = Vector2(window.x/2, 250)
		
	var dividend_group : Area2D = preload("res://minigames/div/div_of_amounts/group.tscn").instantiate()
	dividend_group.position = Vector2(window.x/2, start_position.y-25)	
	dividend_group._arrange()
	print(dividend_group.get_node("Border").shape.size)
	print(dividend_group.get_node("ColorRect").position)
	add_child(dividend_group)
	
	group_container.set("theme_override_constants/separation", 350)
	group_container.set_alignment(group_container.ALIGNMENT_CENTER)
	group_container.size = Vector2(window.x, 800)
	group_container.position.y = start_position.y + 400
	for i in range(divisor):
		var cntrl := Control.new()
		var new_group: Area2D = group.duplicate()
		new_group._arrange()
		cntrl.add_child(new_group)
		group_container.add_child(cntrl)
	add_child(group_container)
	
	_mk_number()

func _mk_number() -> void:
	randomize()
	quotient = (randi() % 10 + 1)
	var dividend : int = 45 #quotient*divisor 	
	
	@warning_ignore("integer_division")
	var tens : int = dividend / 10
	var ones : int = dividend - 10*tens 
	
	var texture_size = one_texture.get_size()
	for i in range(ones):
		var one := Number.new()
		one.position = start_position + Vector2(0, i*texture_size.y)
		one.value = 1
		add_child(one)
		one.button_texture = one_texture
		
	for j in range(tens):
		var ten := Number.new()
		ten.position = start_position - Vector2((j+2)*ten_texture.get_size().x, 0)
		ten.value = 10
		add_child(ten)
		ten.button_texture = ten_texture


	
