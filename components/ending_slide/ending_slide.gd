extends Node2D
class_name EndingSlide

# Note: this node will not work properly unless is at (0, 0)
# It also makes the assumption that there is no camera
# if a camera is implemented later, contact @firesquid6 and I'll help deal with that

@onready var increase_timer: Timer = get_node("IncreaseTimer")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var background: Sprite2D = get_node("Background")
signal animation_complete

var stars: int = -1

func _ready():
	# code just for testing
	if get_parent().name == "root":
		slide_in(3)


# causes the slide in animation to start
# put s as the number of stars to display
func slide_in(s: int):
	stars = s
	animation_player.play("slide_in")
	background.visible = true


func _on_animation_player_animation_finished(anim_name):
	increase_timer.start()


func _on_increase_timer_timeout():
	if sprite.frame < stars:
		increase_timer.start()
		sprite.frame += 1
	else:
		emit_signal("animation_complete")
