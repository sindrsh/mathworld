extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$ScaleBar/Bar.shape.height = $ScaleBar/BarSprite.texture.get_width()
	$ScaleBar/Bar.shape.radius = $ScaleBar/BarSprite.texture.get_height()/2
	
	var bar_side_length : float = $ScaleBar/Bar.shape.height/2
	var container_a = $LeftSide/ContainerSprite.texture.get_width()/2.0
	var container_b = $LeftSide/ContainerSprite.texture.get_height()
	
	var left_rope_vector = Vector2(-container_a, 150)
	var right_rope_vector = Vector2(container_a, 150)
	

	$ScalePilar/Pilar.shape.size = $ScalePilar/PilarSprite.get_rect().size
	$ScalePilar/PilarSprite.position.y = $ScalePilar/PilarSprite.get_rect().size.y/2
	$ScalePilar/Pilar.position = $ScalePilar/PilarSprite.position
	
	$ScalePilarJoint.position = Vector2(0, $ScaleBar/Bar.shape.radius)
	
	$ScaleBar/LeftBarPin1.position = Vector2(-bar_side_length, 0)
	$LeftSide.position = $ScaleBar/LeftBarPin1.global_position + Vector2(0, left_rope_vector.y)
	$ScaleBar/RightBarPin1.position = Vector2(bar_side_length, 0)
	$RightSide.position = $ScaleBar/RightBarPin1.global_position + Vector2(0, right_rope_vector.y)
		
	
	$LeftLeftRope/Rope.shape.height = left_rope_vector.length()
	$LeftLeftRope.position = $LeftSide.position + Vector2(left_rope_vector.x/2, -left_rope_vector.y/2)
	$LeftLeftRope.rotate(PI/2 - right_rope_vector.angle())
	
	# note: RigidBody positions must be set before
	# assigning them to Pins
	$ScaleBar/LeftBarPin1.node_a = $ScaleBar.get_path()
	$ScaleBar/LeftBarPin1.node_b = $LeftLeftRope.get_path()
	
	$LeftRightRope/Rope.shape.height = right_rope_vector.length()
	$LeftRightRope.position = $LeftSide.position - left_rope_vector/2
	$LeftRightRope.rotate(PI/2 - left_rope_vector.angle())
	$ScaleBar/LeftBarPin2.position = Vector2(-bar_side_length, 0)
	$ScaleBar/LeftBarPin2.node_a = $ScaleBar.get_path()
	$ScaleBar/LeftBarPin2.node_b = $LeftRightRope.get_path()
	
	$LeftSide/Pin1.position.x = -container_a
	$LeftSide/Pin1.node_a = $LeftLeftRope.get_path()
	$LeftSide/Pin1.node_b = $LeftSide.get_path()
	
	$LeftSide/Pin2.position.x = container_a
	$LeftSide/Pin2.node_a = $LeftRightRope.get_path()
	$LeftSide/Pin2.node_b = $LeftSide.get_path()

	$RightLeftRope/Rope.shape.height = left_rope_vector.length()
	$RightLeftRope.position = $RightSide.position + Vector2(left_rope_vector.x/2, -left_rope_vector.y/2)
	$RightLeftRope.rotate(PI/2 - right_rope_vector.angle())
	
	# note: RigidBody positions must be set before
	# assigning them to Pins
	$ScaleBar/RightBarPin1.node_a = $ScaleBar.get_path()
	$ScaleBar/RightBarPin1.node_b = $RightLeftRope.get_path()
	
	$RightRightRope/Rope.shape.height = right_rope_vector.length()
	$RightRightRope.position = $RightSide.position - left_rope_vector/2
	$RightRightRope.rotate(PI/2 - left_rope_vector.angle())
	$ScaleBar/RightBarPin2.position = Vector2(bar_side_length, 0)
	$ScaleBar/RightBarPin2.node_a = $ScaleBar.get_path()
	$ScaleBar/RightBarPin2.node_b = $RightRightRope.get_path()
	
	$RightSide/Pin1.position.x = -container_a
	$RightSide/Pin1.node_a = $RightLeftRope.get_path()
	$RightSide/Pin1.node_b = $RightSide.get_path()
	
	$RightSide/Pin2.position.x = container_a
	$RightSide/Pin2.node_a = $RightRightRope.get_path()
	$RightSide/Pin2.node_b = $RightSide.get_path()
	
	$LeftLeftRope.add_collision_exception_with($LeftRightRope)
	$RightRightRope.add_collision_exception_with($RightLeftRope)
	
	$LeftSide/ContainerSprite.position.y = container_b/2
	$RightSide/ContainerSprite.position.y = container_b/2
	$LeftSide/Container/Box.shape.size = Vector2(2*container_a, container_b)
	$LeftSide/Container/Box.position = $LeftSide/ContainerSprite.position
	$RightSide/Container/Box.shape.size = Vector2(2*container_a, container_b)
	$RightSide/Container/Box.position = $RightSide/ContainerSprite.position
	
	
	$LeftSide/Top.shape.a = Vector2(-container_a, 0)
	$LeftSide/Top.shape.b = Vector2(container_a, 0)
	$LeftSide/Bottom.shape.a = Vector2(-container_a, container_b)
	$LeftSide/Bottom.shape.b = Vector2(container_a, container_b)
	$LeftSide/Left.shape.a = Vector2(-container_a, 0)
	$LeftSide/Left.shape.b = Vector2(-container_a, container_b)
	$LeftSide/Right.shape.a = Vector2(container_a, 0)
	$LeftSide/Right.shape.b = Vector2(container_a, container_b)
	
	position = Vector2(600, 400)

