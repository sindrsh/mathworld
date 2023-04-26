extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScaleBar/Bar.shape.height = $ScaleBar/BarSprite.texture.get_width()
	$ScaleBar/Bar.shape.radius = $ScaleBar/BarSprite.texture.get_height()/2

	$LeftRope/Rope.shape.height = $LeftRope/RopeSprite.texture.get_height()
	$RightRope/Rope.shape.height = $RightRope/RopeSprite.texture.get_height() 
	$ScalePilar/Pilar.shape.size = $ScalePilar/PilarSprite.get_rect().size
	$ScalePilar/PilarSprite.position.y = $ScalePilar/PilarSprite.get_rect().size.y/2
	$ScalePilar/Pilar.position = $ScalePilar/PilarSprite.position
	
	var bar_side_length : float = $ScaleBar/Bar.shape.height/2
	
	$ScalePilarJoint.position = Vector2(0, $ScaleBar/Bar.shape.radius)
	
	$LeftRope.position = Vector2(-bar_side_length, $LeftRope/Rope.shape.height/2 + $ScaleBar/Bar.shape.radius)
	$RightRope.position = Vector2(bar_side_length, $RightRope/Rope.shape.height/2 + $ScaleBar/Bar.shape.radius)
	
	$ScaleBar/LeftBarPin.position = Vector2(-bar_side_length, 0)
	$ScaleBar/LeftBarPin.node_a = $ScaleBar.get_path()
	$ScaleBar/LeftBarPin.node_b = $LeftRope.get_path()
	
	$ScaleBar/RightBarPin.position = Vector2(bar_side_length, 0)
	$ScaleBar/RightBarPin.node_a = $ScaleBar.get_path()
	$ScaleBar/RightBarPin.node_b = $RightRope.get_path()
	
	$LeftSide.position = $LeftRope.position + Vector2(0, $LeftRope/Rope.shape.height/2)
	$RightSide.position = $RightRope.position + Vector2(0, $RightRope/Rope.shape.height/2)
	$LeftSide/PinJoint.node_a = $LeftRope.get_path()
	$LeftSide/PinJoint.node_b = $LeftSide.get_path()
	$RightSide/PinJoint.node_a = $RightRope.get_path()
	$RightSide/PinJoint.node_b = $RightSide.get_path()
	
	var container_a = $LeftSide/ContainerSprite.texture.get_width()/2
	var container_b = $LeftSide/ContainerSprite.texture.get_height()
	$LeftSide/ContainerSprite.position.y += container_b/2
	$RightSide/ContainerSprite.position.y += container_b/2
	$LeftSide/Top.shape.a = Vector2(-container_a, 0) 
	$LeftSide/Top.shape.b = Vector2(container_a, 0) 
	$LeftSide/Bottom.shape.a = Vector2(-container_a, container_b) 
	$LeftSide/Bottom.shape.b = Vector2(container_a, container_b) 
	$LeftSide/Left.shape.a = Vector2(-container_a, 0) 
	$LeftSide/Left.shape.b = Vector2(-container_a, container_b) 
	$LeftSide/Right.shape.a = Vector2(container_a, 0) 
	$LeftSide/Right.shape.b = Vector2(container_a, container_b) 
	$LeftSide/Container/Box.shape.size = Vector2(2*container_a, container_b) 		
	
