extends CharacterBody2D

const SPEED := 20.0
const JUMP_VELOCITY := -20.0
const bottom_margin = 100

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var collision: CollisionShape2D = get_node("Collision")
var value : int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 50.0

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	velocity.y += gravity * delta

	if position.y > get_viewport_rect().size.y+bottom_margin:
		queue_free()
	
	move_and_slide()


func kill():
	collision.queue_free()
	animation_player.play("kill")



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "kill":
		queue_free()
