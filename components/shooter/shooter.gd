extends Node2D
class_name Shooter

@onready var zombies_container: Node2D = get_node("Zombies")
@onready var polygon: Polygon2D = get_node("Polygon2D")

var number_zombie_scene: PackedScene = preload("res://components/number_zombie/number_zombie.tscn")
var bullet_scene: PackedScene = preload("res://components/bullet/bullet.tscn")
var ammo: int = 0  # This is NOT the amount of ammo. It represents the number that the shooter will shoot.
var has_ammo: bool = false  # whether the shooter can shoot or not
var score = 0
@export var health: int = 10
@export var bullet_speed: int = 800

@export var spawn_operator: String = "+"

@export var default_color: Color = Color(0.5, 0.5, 0.5);
@export var ready_color: Color = Color(0.5, 1, 0.5);

signal damange_taken(health: int)
signal dead()
signal score_changed(score: int)

func _ready():
  polygon.color = default_color

func spawn(speed: int, spawn_radius: float) -> void:
  var spawn_position = Vector2(spawn_radius, 0).rotated(randf_range(0, 2 * PI))
  var instance: NumberZombie = number_zombie_scene.instantiate()
  zombies_container.add_child(instance)

  instance.speed = speed
  instance.target = Vector2(0, 0)
  instance.position = spawn_position
  instance.operands = [randi() % 10, randi() % 10]

  instance.connect("kill", _on_kill)
  instance.connect("hit", _on_zombie_hit)


func _on_zombie_hit(zombie: NumberZombie) -> void:
  health -= 1
  if health <= 0:
	queue_free()
	emit_signal("dead")

  emit_signal("damange_taken", health)
  zombie.queue_free()


func _on_kill() -> void:
  score += 1000
  emit_signal("score_changed", score)


func _input(event) -> void:
  if event is InputEventMouseButton:
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
	  shoot()


func shoot() -> void:
  if has_ammo:
	polygon.color = default_color
	var instance: Bullet = bullet_scene.instantiate()
	get_parent().add_child(instance)

	instance.position = position

	# get a vector pointing to the mouse
	var mouse_position = get_local_mouse_position().normalized()

	instance.shoot(mouse_position * bullet_speed, ammo)

	has_ammo = false


func _give_ammo(number: int) -> void:
  polygon.color = ready_color
  has_ammo = true
  ammo = number
