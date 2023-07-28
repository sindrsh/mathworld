extends Area2D
class_name Bullet


var velocity := Vector2(0, 0)
var number := 0

@onready var polygon: Polygon2D = get_node("Polygon2D")
@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func shoot(new_velocity: Vector2, new_number: int) -> void:
	self.velocity = new_velocity
	self.number = new_number

	# point collision shape and polygon in the direction of the bullet
	collision_shape.rotation = velocity.angle() + PI / 2
	polygon.rotation = velocity.angle() + PI / 2


func _on_area_entered(area:Area2D):
	if area as NumberZombie :
		area.shoot(number);
	queue_free();


func _physics_process(delta):
	position += velocity * delta

	# lazy solution to ensure that stray bullets don't stick around forever
	# if we ever need to make bullets that go farther than 10000 away this  will need to be refactored
#	if abs(position.x > 10000) || abs(position.y) > 10000:
#		queue_free()
