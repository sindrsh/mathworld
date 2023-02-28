extends Node2D

var button_scene : PackedScene = preload("res://minigames/frac/frac_laser/tick_button.tscn")

var x_scale : float = 600.0
var dy : float = 40.0

var max_int : int = 3
var max_length : float = max_int*x_scale
var number_line1_pos : Vector2 = Vector2(50, 100)
var number_line2_pos : Vector2 = Vector2(number_line1_pos.x, 800)
var objects : Array 
var number_line1 : NumberLine
var number_line2 : NumberLine
var num1 : int
var denom1 : int
var num2 : int
var denom2 : int
var tick_buttons : Array = []

var sub_numbers : Array = [
	[],
	[],
	[2, 3, 5],
	[2, 3],
	[2],
	[2]
]

func _mk_num_line(denominator : int, num_line_pos : Vector2) -> NumberLine:
	var dx : float = 1.0/denominator
	var number_line = NumberLine.new()
	number_line.mk_x_axis(0.0, max_int, x_scale)
	
	number_line.mk_x_tick(Vector2(0, 0), "0")
	
	for i in range(int(max_int/dx)+1):
		number_line.mk_x_tick(Vector2(i*dx*x_scale, 0))
		var tick_frac : FracLabel = FracLabel.new(str(i), str(denominator), 30)		
		if i > 0:
			tick_frac.position = number_line.position + Vector2(i*dx*x_scale, 60)
			number_line.add_child(tick_frac)	
	number_line.position = num_line_pos
	return number_line

# Called when the node enters the scene tree for the first time.
func _on_send_laser(index):
	if index*denom1 == num1*denom2:
		$Laser.is_hitting = true
	$Laser.position = number_line2_pos + Vector2(float(index)/denom2*x_scale, 0)
	$Laser.target = Vector2($Laser.position.x, number_line1_pos.y)
	$Laser.moving = true

func _mk_task():
	$Laser.is_hitting = false
	$Laser.position = number_line2_pos
	$Laser.show()
	if number_line1:
		number_line1.queue_free()
	if number_line2:
		number_line2.queue_free()
	for i in range(tick_buttons.size()):
		tick_buttons[i].queue_free()
	tick_buttons = []
	
	randomize()
	denom1 = randi() % 4 +2
	num1 = randi() % (max_int*denom1) + 1
	denom2 = denom1*sub_numbers[denom1][randi() % sub_numbers[denom1].size()]
	
	$Monster.scale = 0.3*Vector2(1,1)
	$Monster.position = number_line1_pos + Vector2(float(num1)/denom1*x_scale, -50)
	
	number_line1 = _mk_num_line(denom1, number_line1_pos)
	add_child(number_line1)
	
	number_line2 = _mk_num_line(denom2, number_line2_pos)
	add_child(number_line2)
#	number_line2.tick_list[num2+1].default_color = Color(0,1,0)
	
	for i in range(max_int*denom2 +1):	
		var tick_button : Button = button_scene.instantiate()
		tick_button.size = Vector2(0.4/denom2*x_scale, 100)
		tick_button.position = number_line2_pos + Vector2(i*1.0/denom2*x_scale, 0) - 0.5*tick_button.size
		tick_button.index = i
		add_child(tick_button)
		tick_buttons.append(tick_button)
		assert(tick_button.connect("send_laser", _on_send_laser) == 0)

func _on_laser_arrival():
	$Laser.hide()
	_mk_task()		
	
func _ready():
	var one_label1 : Text = Text.new(42, "1")
	one_label1.set_position(number_line1_pos + Vector2(x_scale-11, -70))		
	add_child(one_label1)
	var one_label2 : Text = Text.new(42, "1")
	one_label2.set_position(number_line2_pos + Vector2(x_scale-11, -70))		
	add_child(one_label2)
	
	$Laser.position = number_line2_pos
	_mk_task()
	
	assert($Laser.connect("move_completed", _on_laser_arrival) == 0)
	
