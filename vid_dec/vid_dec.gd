extends "res://VideoPlayer.gd"

var tick_scene = preload("res://vid_dec/Tick.tscn")
var ticks100 = 101
var dx = 1600/(ticks100-1)
var line_a = Vector2(150,800)
var line_b = Vector2(line_a.x + (ticks100-1)*dx, line_a.y)

var tick_count_label
var ticks100list = []
var ticks10list = []
var numbers100list = []
var numbers10list = []

var cnt_pos1
var cnt_pos2
var cnt_pos3

# Called when the node enters the scene tree for the first time.
func _ready():
	set_frame_max(7)
	
	for i in range(ticks100):
		var tick = tick_scene.instance()
		add_child(tick)
		if i % 10 == 0:
			ticks10list.append(tick)
		ticks100list.append(tick)
		tick.position = Vector2(line_a.x + dx*i, line_a.y)
		
	GlobalVariables.mk_number(self, "0", null, Vector2(line_a.x, line_a.y+40), 0.5, 20, 5, 10, 10)
	GlobalVariables.mk_number(self, "1", null, Vector2(line_a.x+100*dx, line_a.y+40), 0.5, 20, 5, 10, 10)
	
	for i in range(ticks100list.size()):
		view_list.append(ticks100list[i])
		if i < 10:
			numbers100list.append(GlobalVariables.mk_number(self, "0","0"+String(i % 100), Vector2(line_a.x-15+i*dx, line_a.y-40), 0.5, 20, 5, 10, 10))	
		else: 
			numbers100list.append(GlobalVariables.mk_number(self, "0", String(i % 100), Vector2(line_a.x-15+i*dx, line_a.y-40), 0.5, 20, 5, 10, 10))	
		for num in numbers100list[i]:
			view_list.append(num)
		
		
	for i in range(ticks10list.size()):
		view_list.append(ticks10list[i])
		numbers10list.append(GlobalVariables.mk_number(self, "0", String(i % 10), Vector2(line_a.x-15+10*i*dx, line_a.y+40), 0.5, 20, 5, 10, 10))	
		for num in numbers10list[i]:
			view_list.append(num)
		
	tick_count_label = GlobalVariables.get_label(50, Color(1,1,1))
	tick_count_label.rect_position = $Ticks.rect_position + Vector2(60,0)
	cnt_pos1 = tick_count_label.rect_position
	cnt_pos2 = cnt_pos1 - Vector2(25,0)
	cnt_pos3 = cnt_pos2 - Vector2(25, 0)
	tick_count_label.text = "0"
	
	$Ticks.hide()
	tick_count_label.hide()
	add_child(tick_count_label)
	
	mk_frame_func_list()
	update()
	
func _draw():
	draw_line(line_a, line_b, Color(0,0,0), 3.5, true)

var time = 0
var cnt = 0
func _physics_process(delta):
	time += delta
	
	if frame == 1:
		if time > 0.5 and cnt < ticks10list.size() - 1:
			ticks10list[cnt+1].show()
			ticks10list[cnt+1].frame = 1
			if cnt+1 == 10:
				tick_count_label.rect_position = cnt_pos2
			tick_count_label.text = String(cnt+1)
			cnt += 1 
			time = 0
			
	if frame == 2:
		if time > 1.25 and cnt < ticks10list.size() - 2:
			ticks10list[cnt].frame = 0
			ticks10list[cnt+1].frame = 1
			show_on_screen(numbers10list[cnt+1])
			cnt += 1 
			time = 0
		if time > 1.5 and cnt < ticks10list.size() - 1:
			ticks10list[cnt].frame = 0
			cnt += 1 

	if frame == 4:
		if time > 0.07 and cnt < ticks100list.size() - 1:
			ticks100list[cnt+1].show()
			ticks100list[cnt+1].frame = 1
			if cnt+1 == 10:
				tick_count_label.rect_position = cnt_pos2
			if cnt+1 == 100:
				tick_count_label.rect_position = cnt_pos3	
			tick_count_label.text = String(cnt+1)
			cnt += 1 
			time = 0
			
	if frame == 5:
		if time > 0.1 and cnt < ticks100list.size() - 2:
			ticks100list[cnt].frame = 0
			ticks100list[cnt+1].frame = 1
			for dig in numbers100list[cnt]:
				dig.hide()
			show_on_screen(numbers100list[cnt+1])
			cnt += 1 
			time = 0
			
		if time > 1.5 and cnt < ticks100list.size() - 1:
			ticks100list[cnt].frame = 0
			for dig in numbers100list[cnt]:
				dig.hide()
			cnt += 1
			
func frame0():
	cnt = 0
	ticks10list[0].visible = true 
	ticks10list[-1].visible = true 
	$Ticks.hide()
	tick_count_label.hide()
	ticks10list[-1].frame = 0
	
func frame1():
	$Ticks.show()
	tick_count_label.show()
	pass

func frame2():
	tick_count_label.rect_position = cnt_pos1
	$Ticks.hide()
	tick_count_label.hide()
	for tick in ticks10list:
		tick.show()
		tick.frame = 0

func frame3():
	for i in range(1, ticks10list.size()-1):
		ticks10list[i].hide()

func frame4():
	$Ticks.show()
	tick_count_label.text = "0"
	tick_count_label.show()
	for i in range(1, ticks10list.size()-1):
		ticks10list[i].hide()

func frame5():
	$Ticks.hide()
	tick_count_label.hide()
	for tick in ticks100list:
		tick.frame = 0	
		tick.show()
	if frame6_shown: 
		for i in range(10, numbers100list.size()-10):
			if i % 10 == 0:
				for dig in numbers100list[i]:
					dig.position = dig.position - Vector2(0, 80)
		frame6_shown = false

var frame6_shown = false
func frame6():
	frame6_shown = true
	print("hei")
	for i in range(numbers100list.size()):
		if i % 5 == 0:
			if i != 0 and i != 100:
				if i % 10 == 0:
					for dig in numbers100list[i]:
						if i == 10: print(dig.position)
						dig.position = dig.position + Vector2(0, 80)
				show_on_screen(numbers100list[i])
				ticks100list[i].frame = 1
				
