extends Node2D

var dx := 20.0
var size100 : float
var size10 : float
var size1 : float
var start_x : float
var size1alt : float


func arrange():
	size100 = _get_frame_size($Hundreds)
	size10 = _get_frame_size($Tens)
	size1 = _get_frame_size($Ones)
	size1alt = _get_frame_size($OnesAlt)
	
	var total_size := size100 + size10 + + size1 + 2*dx
	start_x = ($Panel.size.x - total_size)/2
	
	$Hundreds.position = Vector2(start_x, 20)
	$Tens.position = Vector2(start_x + size100 + dx, 20)
	$Ones.position = Vector2(start_x + size100 + size10 + 2*dx, 20)
	$OnesAlt.position = Vector2(start_x + size100 + size10 + 2*dx, 120)
	
	
func _get_frame_size(animation : AnimatedSprite2D) -> float:
	if animation.sprite_frames.get_frame_texture("default", animation.frame):
		return animation.sprite_frames.get_frame_texture("default", animation.frame).get_size().x
	return 0.0
