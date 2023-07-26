extends Node2D
class_name Shooter

@onready var zombies_container: Node2D = get_node("Zombies");
var number_zombie_scene: PackedScene = preload("res://components/number_zombie/number_zombie.tscn");
@export var health: int = 10;

signal damange_taken()
signal dead()

func spawn(speed: int, spawn_radius: float):
  var spawn_position = Vector2(randf_range(0, spawn_radius), 0).rotated(randf_range(0, 2 * PI));
  var instance: NumberZombie = number_zombie_scene.instantiate();
  zombies_container.add_child(instance);

  instance.speed = speed;
  instance.target = Vector2(0, 0);
  instance.position = spawn_position;
  instance.operands = [randi() % 10, randi() % 10];

  instance.connect("hit", _on_zombie_hit);


func _on_zombie_hit(zombie: NumberZombie):
  health -= 1;
  if health <= 0:
    emit_signal("dead");

  emit_signal("damange_taken");

  zombie.queue_free();