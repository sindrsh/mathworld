extends Node2D

signal rolled_fwd(add : bool)
signal rolled_bckwd

var current_number := 0
var bar_length : int
var roll_wait := 0.05

func _ready():
	var num_label := _mk_num_label("0")
	$Zero.add_child(num_label)

	bar_length = $Bar.texture.get_width()
	
	for i in range(9):
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = $Zero.position + Vector2(i*bar_length, 0)
		bar.show()
		num_label = _mk_num_label(str(i+1))
		bar.add_child(num_label)
		add_child(bar)
	current_number = 9	


func add_ten() -> bool:
	var num_label := _mk_num_label("0")
	
	for i in range(10):
		var k = current_number + i
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = $Zero.position + Vector2(k*bar_length, 0)
		bar.show()
		num_label = _mk_num_label(str(k+1))
		if i == 0:
			num_label.set_color(Color(0,0,1))
		else:
			num_label.set_color(Color(0,0,0))
		bar.add_child(num_label)
		await get_tree().create_timer(0.1).timeout
		add_child(bar)
	current_number += 10		
	return true
	

func roll_ten_fwd(_add: bool) -> void:
	for i in range(10):
		await get_tree().create_timer(roll_wait).timeout
		position.x -= bar_length
	emit_signal("rolled_fwd", _add)


func roll_ten_bckwd() -> void:
	for i in range(10):
		await get_tree().create_timer(roll_wait).timeout
		position.x += bar_length
	emit_signal("rolled_bckwd")
 

func add_100() -> void:
	var num_label := _mk_num_label("100")
	num_label.set_color(Color(0,0,1))
	var bar : Sprite2D = $Bar.duplicate()
	bar.position = $Zero.position + Vector2(99*bar_length, 0)
	bar.add_child(num_label)
	bar.show()
	add_child(bar)


func _mk_num_label(num_str : String) -> Text:
	var _num_label = Text.new(50, num_str)
	_num_label.set_text_position(Vector2(bar_length, 30))
	return _num_label
