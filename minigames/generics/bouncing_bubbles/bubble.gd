extends CharacterBody2D

signal bubble_pressed(_name : String)

var speed : int = 100
var int_value : Array
var float_value : float
var representation : int
var collision_shape := CollisionShape2D.new()
var not_chosen_texture : Texture2D
var chosen_texture : Texture2D

var button := TextureButton.new()

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _init():
	collision_shape.shape = CircleShape2D.new()

func _ready():
	assert(button.connect("pressed", _on_pressed) == 0)
	
	add_child(collision_shape)
	
	button.texture_normal = not_chosen_texture
	
	add_child(button)
	
	
	
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	
	
func _on_pressed() -> void:
	emit_signal("bubble_pressed", name)
		
		
func start(_position, _direction) -> void:
	position = _position
	velocity = Vector2(speed, 0).rotated(_direction)


func on_kill() -> void:
	animation_player.play("fade_out")

func play_wrong_choice() -> void:
	animation_player.play("wrong_choice")

func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "fade_out":
		queue_free()


func shake() -> void:
	var start_pos := position
	randomize()
	for i in range(10):
		var angle = randf_range(0, 2*PI)
		position += 10*Vector2(cos(angle), sin(angle))
		await get_tree().create_timer(0.01).timeout
	position = start_pos
