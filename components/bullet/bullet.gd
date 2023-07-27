extends Area2D
class_name Bullet


var velocity = Vector2(0, 0)
var on_hit = func(_body: CollisionObject2D): pass 


func shoot(new_velocity: Vector2, new_on_hit: Callable) -> void:
	self.velocity = new_velocity
	self.on_hit = new_on_hit
	$CollisionShape2D.disabled = false

func _on_area_entered(area:Area2D):
	on_hit.call(area); # "first class functions" my ass
