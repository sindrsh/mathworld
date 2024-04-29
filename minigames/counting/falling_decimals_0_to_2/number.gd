extends Node2D

signal selected


@export var speed_multiplier: int = 10

var value
var speed = Vector2(2000, 30)
var tick
var find_tick = false

var comma_y = 10
var num_scale = 0.5
var num_pos = Vector2(100,100)
var moving = true

var hovered = false
var is_exiting = false

@onready var animation_player = get_node("AnimationPlayer")
@onready var outline_material = preload("res://assets/materials/texture_border.tres")


func _on_timeout():
	animation_player.play("fade_out")

	
func _change_speed():
	speed = Vector2(speed.x, 1.4*speed.y)


func _ready():
	position = num_pos
	speed.y += speed_multiplier * get_parent().difficulty
	
	assert($TextureButton.pressed.connect(_on_pressed) == 0)
	assert($ExitTimer.timeout.connect(_on_timeout) == 0)	


func _process(delta):
	if find_tick == true:
		var x1 = position.x
		var x2 = tick.position.x
		if abs(x1 - x2) > delta*speed.x:
			position.x = x1 - (x1-x2)/abs(x1-x2)*delta*speed.x
		else:
			position.x = x2
	else:
		if position.y > get_parent().line_a.y - 20:
			if not is_exiting:
				get_parent().validate($TickDetector, null)
				is_exiting = true
	
	if moving:
		position.y += delta*speed.y


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		queue_free()

func _on_pressed() -> void:
	emit_signal("selected", self)

func apply_outline():
	$Sprite2D.material = outline_material

func remove_outline():
	$Sprite2D.material = null
