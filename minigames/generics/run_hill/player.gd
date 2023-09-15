extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.x = 100.0
	velocity.y += gravity * delta
	var road_segment = get_last_slide_collision()
	if road_segment:
		pass
#		rotation = road_segment.get_angle()
	move_and_slide()
	
