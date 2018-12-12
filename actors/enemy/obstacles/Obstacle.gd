extends Node2D

signal hit_obstacle

const OBJECT_SPEED = 300

var direction = Vector2(-1, 0)
export var damage_amount = 10

func _process(delta):
	position += OBJECT_SPEED * direction * delta
	
	if position.x < 0:
		queue_free()
		
func _on_RigidBody2D_area_shape_entered(area_id, area, area_shape, self_shape):
	emit_signal("hit_obstacle", damage_amount)