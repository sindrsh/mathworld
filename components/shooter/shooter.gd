extends Node2D
class_name Shooter

@onready var zombies_container: Node2D = get_node("Zombies");
var number_zombie_scene: PackedScene = preload("res://components/number_zombie/number_zombie.tscn");
var bullet_scene: PackedScene = preload("res://components/bullet/bullet.tscn");
var ammo: int = 0  # This is NOT the amount of ammo. It represents the number that the shooter will shoot.
var has_ammo: bool = false  # whether the shooter can shoot or not
@export var health: int = 10;

signal damange_taken()
signal dead()

func spawn(speed: int, spawn_radius: float) -> void:
  var spawn_position = Vector2(randf_range(0, spawn_radius), 0).rotated(randf_range(0, 2 * PI));
  var instance: NumberZombie = number_zombie_scene.instantiate();
  zombies_container.add_child(instance);

  instance.speed = speed;
  instance.target = Vector2(0, 0);
  instance.position = spawn_position;
  instance.operands = [randi() % 10, randi() % 10];

  instance.connect("hit", _on_zombie_hit);


func _on_zombie_hit(zombie: NumberZombie) -> void:
  health -= 1;
  if health <= 0:
    emit_signal("dead");

  emit_signal("damange_taken");

  zombie.queue_free();


func shoot() -> void:
  if has_ammo:
    var instance: Bullet = bullet_scene.instantiate();
    get_parent().add_child(instance);

    instance.position = position;
    instance.shoot(Vector2(0, 0), func(area):
      if area != null:  # no way to actually make sure that this is a zombie because Godot 4 only pretends to support first class functions. Just ensure that nothing else in the scene is collision layer 2
        area.queue_free();
    )


    has_ammo = false;


func _give_ammo(number: int) -> void:
  has_ammo = true;
  ammo = number;