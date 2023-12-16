extends Node2D
class_name EndingSlide

# Note: this node will not work properly unless is at (0, 0)
# It also makes the assumption that there is no camera
# if a camera is implemented later, contact @firesquid6 and I'll help deal with that


@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


# causes the slide in animation to start
# put stars as the number of stars to display
func slide_in(stars: int):
	animation_player.play("slide_in")
	print("I'm sliding in")
